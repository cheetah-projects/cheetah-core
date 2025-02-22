import 'dart:convert';
import 'dart:io';
import 'dart:math';

class Utils {
  static String generateUuid() {
    final random = Random();
    return '${_randomHex(8, random)}-${_randomHex(4, random)}-${_randomHex(4, random)}-${_randomHex(4, random)}-${_randomHex(12, random)}';
  }

  static String _randomHex(int length, Random random) {
    const chars = '0123456789abcdef';
    return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
  }

  static Map<String, dynamic> readJsonFile(String path) {
    final file = File(path);
    if (!file.existsSync()) return {};
    return jsonDecode(file.readAsStringSync());
  }

  static void writeJsonFile(String path, Map<String, dynamic> data) {
    final file = File(path);
    file.writeAsStringSync(jsonEncode(data), mode: FileMode.write);
  }

  static String base64EncodeString(String input) {
    return base64Encode(utf8.encode(input));
  }

  static String base64DecodeString(String encoded) {
    return utf8.decode(base64Decode(encoded));
  }

  static bool isValidEmail(String email) {
    final regex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return regex.hasMatch(email);
  }

  static bool isValidUrl(String url) {
    final regex = RegExp(r"^https?:\/\/[^\s$.?#].[^\s]*$");
    return regex.hasMatch(url);
  }

  static String getEnv(String key, {String defaultValue = ''}) {
    return Platform.environment[key] ?? defaultValue;
  }

  static void delay(int milliseconds) async {
    await Future.delayed(Duration(milliseconds: milliseconds));
  }

  static String formatDateTime(DateTime dateTime, {String format = 'yyyy-MM-dd HH:mm:ss'}) {
    return '${dateTime.year}-${_pad(dateTime.month)}-${_pad(dateTime.day)} '
        '${_pad(dateTime.hour)}:${_pad(dateTime.minute)}:${_pad(dateTime.second)}';
  }

  static String _pad(int value) => value.toString().padLeft(2, '0');

  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  static String camelToSnakeCase(String text) {
    return text.replaceAllMapped(RegExp(r'([a-z])([A-Z])'), (match) => '${match.group(1)}_${match.group(2)}').toLowerCase();
  }

  static String snakeToCamelCase(String text) {
    return text.split('_').map((word) => word.isEmpty ? '' : '${word[0].toUpperCase()}${word.substring(1)}').join('');
  }

  static String truncate(String text, int maxLength, {String suffix = '...'}) {
    return text.length > maxLength ? text.substring(0, maxLength) + suffix : text;
  }

  static String obfuscateEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email;
    final name = parts[0];
    final domain = parts[1];
    final hiddenPart = '*' * (name.length - 2);
    return '${name[0]}$hiddenPart${name[name.length - 1]}@$domain';
  }

  static String generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
  }

  static String maskString(String input, {int visibleStart = 2, int visibleEnd = 2, String mask = '*'}) {
    if (input.length <= (visibleStart + visibleEnd)) return input;
    final maskedSection = mask * (input.length - visibleStart - visibleEnd);
    return '${input.substring(0, visibleStart)}$maskedSection${input.substring(input.length - visibleEnd)}';
  }

  static String bytesToHex(List<int> bytes) {
    return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }

  static List<int> hexToBytes(String hex) {
    final result = <int>[];
    for (var i = 0; i < hex.length; i += 2) {
      result.add(int.parse(hex.substring(i, i + 2), radix: 16));
    }
    return result;
  }

  static int currentTimestamp() {
    return DateTime.now().millisecondsSinceEpoch;
  }
}
