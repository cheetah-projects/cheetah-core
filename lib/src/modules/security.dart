import 'dart:convert';
import 'package:crypto/crypto.dart';

class Security {
  static String hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }

  static bool verifyPassword(String password, String hash) {
    return hashPassword(password) == hash;
  }

  static String generateToken(String userId, {Duration expiry = const Duration(hours: 1)}) {
    final payload = {
      'sub': userId,
      'exp': DateTime.now().add(expiry).millisecondsSinceEpoch,
    };
    return base64Url.encode(utf8.encode(jsonEncode(payload)));
  }

  static bool validateToken(String token) {
    try {
      final payload = jsonDecode(utf8.decode(base64Url.decode(token))) as Map<String, dynamic>;
      return payload.containsKey('exp') &&
          DateTime.now().millisecondsSinceEpoch < payload['exp'];
    } catch (_) {
      return false;
    }
  }
}

final security = Security();
