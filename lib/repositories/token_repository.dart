import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class TokenRepository {
  final _storage = const FlutterSecureStorage(mOptions: MacOsOptions.defaultOptions);
  static const _auth = 'auth';

  Future<void> saveTokens({required String auth}) async {
    await _storage.write(key: _auth, value: auth);
  }

  Future<String?> getAuthInfo() => _storage.read(key: _auth);

  Future<void> clearTokens() async {
    await _storage.deleteAll();
  }

  Future<bool> hasValidAuthInfo() async {
    final authInfo = await getAuthInfo();
    if (authInfo == null) return false;

    try {
      return !JwtDecoder.isExpired(authInfo);
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, dynamic>?> getAuthFromToken() async {
    final auth = await getAuthInfo();
    if (auth == null) return null;
    try {
      final decodedToken = JwtDecoder.decode(auth);
      decodedToken['token'] = auth;
      return decodedToken;
    } catch (e) {
      return null;
    }
  }
}
