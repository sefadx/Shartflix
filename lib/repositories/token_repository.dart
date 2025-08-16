import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

// Token'ları güvenli bir şekilde saklamak için.
class TokenRepository {
  final _storage = const FlutterSecureStorage();
  static const _accessTokenKey = 'accessToken';
  static const _refreshTokenKey = 'refreshToken';

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
  }

  Future<String?> getAccessToken() => _storage.read(key: _accessTokenKey);
  Future<String?> getRefreshToken() => _storage.read(key: _refreshTokenKey);

  Future<void> clearTokens() async {
    await _storage.deleteAll();
  }

  // Swift'teki `checkTokenStatus` mantığının karşılığı
  Future<bool> hasValidRefreshToken() async {
    final refreshToken = await getRefreshToken();
    if (refreshToken == null) return false;

    try {
      // Refresh token'ın süresinin dolup dolmadığını kontrol et
      return !JwtDecoder.isExpired(refreshToken);
    } catch (e) {
      // Geçersiz token
      return false;
    }
  }

  Future<String?> getUserIdFromToken() async {
    final refreshToken = await getRefreshToken();
    if (refreshToken == null) return null;
    try {
      final decodedToken = JwtDecoder.decode(refreshToken);
      return decodedToken['userId'];
    } catch (e) {
      return null;
    }
  }
}