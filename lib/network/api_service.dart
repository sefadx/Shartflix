import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'api_error.dart';
import 'api_endpoint.dart';

class Empty {
  const Empty();
  Map<String, dynamic> toJson() => {};
  @override
  String toString() => 'Empty';
}

abstract class IAPIService {
  Future<T> get<T>(ApiEndpoint endpoint, {required T Function(dynamic json) fromJson});

  Future<T> post<T, U>(
    ApiEndpoint endpoint, {
    required U body,
    required T Function(dynamic json) fromJson,
  });

  Future<T> put<T, U>(
    ApiEndpoint endpoint, {
    required U body,
    required T Function(dynamic json) fromJson,
  });

  Future<T> delete<T>(ApiEndpoint endpoint, {required T Function(dynamic json) fromJson});

  Future<dynamic> getJson(ApiEndpoint endpoint);
  Future<dynamic> postJson<U>(ApiEndpoint endpoint, {required U body});
  Future<dynamic> putJson<U>(ApiEndpoint endpoint, {required U body});
  Future<dynamic> deleteJson(ApiEndpoint endpoint);
}

class APIService implements IAPIService {
  final String baseUrl;
  final http.Client _client;
  final String? _token;
  final Duration _timeout;
  final Logger _logger = Logger('ApiService');

  /// [baseUrl]: URL domain (ex: "https://api.example.com")
  /// [token]: Bearer token for permission
  /// [client]: Default: http.Client
  /// [timeout]: Timeout duration of request
  APIService({
    this.baseUrl = 'https://caseapi.servicelabs.tech',
    String? token,
    http.Client? client,
    Duration timeout = const Duration(seconds: 10),
  }) : _token = token,
       _client = client ?? http.Client(),
       _timeout = timeout;

  /// Convert endpoint to URL
  Uri _buildUrl(ApiEndpoint endpoint) {
    final urlString = '$baseUrl${endpoint.path()}';
    final uri = Uri.tryParse(urlString);
    if (uri == null) {
      _logger.severe('Invalid URL generated: $urlString');
      throw InvalidUrlException();
    }
    return uri;
  }

  /// Encode headers with token
  Map<String, String> _buildHeaders() {
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };
    if (_token != null) {
      headers['Authorization'] = 'Bearer $_token';
    }
    return headers;
  }

  /// Validation response by status code success [200...300]
  void _validateResponse(http.Response response) {
    _logger.fine('RESPONSE | Code: ${response.statusCode} | Body: ${response.body}');
    if (response.statusCode < 200 || response.statusCode >= 300) {
      _logger.warning('HTTP status code: ${response.statusCode} for ${response.request?.url}');

      if (response.statusCode == 401) {
        throw UnauthorizedException();
      }
      throw RequestFailedException(statusCode: response.statusCode, responseBody: response.body);
    }
  }

  /// Convert response data into T model. No response model use <Nothing>
  T _decodeData<T>(String body, T Function(dynamic json) fromJson) {
    try {
      if (T == Empty) {
        return Empty() as T;
      }
      final json = jsonDecode(body);
      return fromJson(json);
    } catch (e, stackTrace) {
      _logger.severe('Decoding error: $e', e, stackTrace);
      throw DecodingFailedException(e);
    }
  }

  Future<http.Response> _makeRequest(Future<http.Response> Function() request) async {
    try {
      return await request().timeout(_timeout);
    } on SocketException catch (e, s) {
      _logger.severe('No Internet Connection: $e', e, s);
      throw NoInternetConnectionException();
    } on TimeoutException catch (e, s) {
      _logger.warning('Request Timed Out: $e', e, s);
      throw RequestTimedOutException();
    } on http.ClientException catch (e, s) {
      _logger.severe('Server Unavailable or Client Error: $e', e, s);
      throw ServerUnavailableException();
    }
  }

  @override
  Future<T> get<T>(ApiEndpoint endpoint, {required T Function(dynamic json) fromJson}) async {
    final url = _buildUrl(endpoint);
    _logger.info('GET -> ${url.toString()}');

    try {
      final response = await _makeRequest(() => _client.get(url, headers: _buildHeaders()));
      _validateResponse(response);
      return _decodeData<T>(response.body, fromJson);
    } on ApiException catch (e) {
      _logger.severe('GET Error: ${e.message} | URL: $url');
      rethrow;
    } catch (e, s) {
      _logger.severe('Unexpected GET Error: $e | URL: $url', e, s);
      throw UnexpectedException(e);
    }
  }

  @override
  Future<T> post<T, U>(
    ApiEndpoint endpoint, {
    required U body,
    required T Function(dynamic json) fromJson,
  }) async {
    final url = _buildUrl(endpoint);
    final headers = _buildHeaders();
    final String requestBody;

    try {
      requestBody = jsonEncode((body as dynamic).toJson());
    } catch (e, s) {
      _logger.severe('Encoding failed for POST request to $url', e, s);
      throw EncodingFailedException(e);
    }

    _logger.info('POST -> ${url.toString()} | Body: $requestBody');

    try {
      final response = await _makeRequest(
        () => _client.post(url, headers: headers, body: requestBody),
      );
      _validateResponse(response);
      return _decodeData<T>(response.body, fromJson);
    } on ApiException catch (e) {
      _logger.severe('POST Error: ${e.message} | URL: $url');
      rethrow;
    } catch (e, s) {
      _logger.severe('Unexpected POST Error: $e | URL: $url', e, s);
      throw UnexpectedException(e);
    }
  }

  @override
  Future<T> put<T, U>(
    ApiEndpoint endpoint, {
    required U body,
    required T Function(dynamic json) fromJson,
  }) async {
    final url = _buildUrl(endpoint);
    final headers = _buildHeaders();
    final String requestBody;

    try {
      requestBody = jsonEncode((body as dynamic).toJson());
    } catch (e, s) {
      _logger.severe('Encoding failed for PUT request to $url', e, s);
      throw EncodingFailedException(e);
    }

    _logger.info('PUT -> ${url.toString()} | Body: $requestBody');

    try {
      final response = await _makeRequest(
        () => _client.put(url, headers: headers, body: requestBody),
      );
      _validateResponse(response);
      return _decodeData<T>(response.body, fromJson);
    } on ApiException catch (e) {
      _logger.severe('PUT Error: ${e.message} | URL: $url');
      rethrow;
    } catch (e, s) {
      _logger.severe('Unexpected PUT Error: $e | URL: $url', e, s);
      throw UnexpectedException(e);
    }
  }

  @override
  Future<T> delete<T>(ApiEndpoint endpoint, {required T Function(dynamic json) fromJson}) async {
    final url = _buildUrl(endpoint);
    _logger.info('DELETE -> ${url.toString()}');

    try {
      final response = await _makeRequest(() => _client.delete(url, headers: _buildHeaders()));
      _validateResponse(response);
      return _decodeData<T>(response.body, fromJson);
    } on ApiException catch (e) {
      _logger.severe('DELETE Error: ${e.message} | URL: $url');
      rethrow;
    } catch (e, s) {
      _logger.severe('Unexpected DELETE Error: $e | URL: $url', e, s);
      throw UnexpectedException(e);
    }
  }

  @override
  Future getJson(ApiEndpoint endpoint) {
    return get(endpoint, fromJson: (json) => json);
  }

  @override
  Future postJson<U>(ApiEndpoint endpoint, {required U body}) {
    return post(endpoint, body: body, fromJson: (json) => json);
  }

  @override
  Future putJson<U>(ApiEndpoint endpoint, {required U body}) {
    return put(endpoint, body: body, fromJson: (json) => json);
  }

  @override
  Future deleteJson(ApiEndpoint endpoint) {
    return delete(endpoint, fromJson: (json) => json);
  }
}
