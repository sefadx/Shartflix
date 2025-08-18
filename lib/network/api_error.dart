import 'dart:convert';

sealed class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}

class InvalidUrlException extends ApiException {
  InvalidUrlException() : super("The URL is invalid. Please contact support.");
}

class RequestFailedException extends ApiException {
  final int statusCode;
  final String? responseBody;

  RequestFailedException({required this.statusCode, this.responseBody})
    : super(_extractMessage(responseBody, statusCode));

  static String _extractMessage(String? data, int statusCode) {
    if (data == null || data.isEmpty) {
      return "Request failed with status code $statusCode. Please try again.";
    }
    try {
      final json = jsonDecode(data) as Map<String, dynamic>;
      return json['message'] as String? ?? "Request failed with status code $statusCode.";
    } catch (_) {
      return "Request failed with status code $statusCode. Invalid error format.";
    }
  }
}

class DecodingFailedException extends ApiException {
  DecodingFailedException(Object originalError)
    : super("Failed to process the response. Please try again later. Error: $originalError");
}

class EncodingFailedException extends ApiException {
  EncodingFailedException(Object originalError)
    : super("Failed to send your data. Please try again. Error: $originalError");
}

class NoInternetConnectionException extends ApiException {
  NoInternetConnectionException()
    : super("No internet connection. Please check your network settings.");
}

class RequestTimedOutException extends ApiException {
  RequestTimedOutException() : super("The request timed out. Please try again later.");
}

class ServerUnavailableException extends ApiException {
  ServerUnavailableException()
    : super("The server is currently unavailable. Please try again in a few moments.");
}

class InvalidTokenException extends ApiException {
  InvalidTokenException()
    : super("Your session token is invalid or corrupted. Please log in again.");
}

class UnauthorizedException extends ApiException {
  UnauthorizedException()
    : super("Your session has expired or you are not authorized. Please sign in to continue.");
}

class CustomException extends ApiException {
  CustomException(String message) : super(message);
}

class UnexpectedException extends ApiException {
  UnexpectedException(Object error) : super("An unexpected error occurred: $error");
}
