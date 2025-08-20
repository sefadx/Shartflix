import 'dart:ffi';

sealed class ApiEndpoint {
  const ApiEndpoint();

  /// path of endpoint
  String path();

  static const String _base = "";
  static const String _baseAuth = "$_base/auth";
  static const String _baseUser = "/user";
  static const String _baseMovie = "/movie";
  static String _baseMovieFavorites({String? id}) {
    String path;
    if (id != null) {
      path = "$_baseMovie/favorite/$id";
    } else {
      path = "$_baseMovie/favorites";
    }
    return path;
  }

  static const String _baseTeam = "$_base/team";
  static const String _baseMe = "$_base/me";
  static const String _baseData = "$_base/data";
  static const String _baseTrip = "$_base/trip";
  static String _baseRoutes(String tripId) => "$_baseTrip/$tripId/routes";

  /// Add encoded query parameters to URL
  String _buildPathWithQuery(String basePath, Map<String, dynamic> params) {
    final validParams = Map<String, String>.fromEntries(
      params.entries
          .where((entry) => entry.value != null)
          .map((entry) => MapEntry(entry.key, entry.value.toString())),
    );

    if (validParams.isEmpty) {
      return basePath;
    }

    final queryString = Uri(queryParameters: validParams).query;
    return '$basePath?$queryString';
  }
}

// --- Auth Endpoints ---

class LoginEndpoint extends ApiEndpoint {
  const LoginEndpoint();
  @override
  String path() => "${ApiEndpoint._baseUser}/login";
}

class RegisterEndpoint extends ApiEndpoint {
  const RegisterEndpoint();
  @override
  String path() => "${ApiEndpoint._baseUser}/register";
}

class PhotoUploadEndpoint extends ApiEndpoint {
  const PhotoUploadEndpoint();
  @override
  String path() => "${ApiEndpoint._baseUser}/upload_photo";
}

// --- Movie Endpoints ---

class MovieEndpoint extends ApiEndpoint {
  final int page;
  const MovieEndpoint({required this.page});
  @override
  String path() {
    const basePath = "${ApiEndpoint._baseMovie}/list";
    final params = {'page': page};
    return _buildPathWithQuery(basePath, params);
  }
}

class MovieFavoritesEndpoint extends ApiEndpoint {
  final String? id;
  const MovieFavoritesEndpoint({this.id});
  @override
  String path() => ApiEndpoint._baseMovieFavorites(id: id);
}

// --- User Endpoints ---

class ProfileEndpoint extends ApiEndpoint {
  final String? id;
  final String? username;

  const ProfileEndpoint({this.id, this.username});

  @override
  String path() {
    const basePath = "${ApiEndpoint._baseUser}/profile";
    final params = {'id': id, 'username': username};
    return _buildPathWithQuery(basePath, params);
  }
}
