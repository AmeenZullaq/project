import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  // Single, shared instance
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  // STRING
  static Future<void> setString(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  static Future<String?>? getString(String key) async {
    return _storage.read(key: key);
  }

  // // BOOL (stored as "true"/"false")
  // static Future<void> setBool(String key, bool value) async {
  //   await _storage.write(key: key, value: value.toString());
  // }

  // static Future<bool?> getBool(String key) async {
  //   final v = await _storage.read(key: key);
  //   if (v == null) return null;
  //   return v.toLowerCase() == 'true';
  // }

  // // STRING LIST (stored as JSON)
  // static Future<void> setStringList(String key, List<String> value) async {
  //   final json = jsonEncode(value);
  //   await _storage.write(key: key, value: json);
  // }

  // static Future<List<String>?> getStringList(String key) async {
  //   final json = await _storage.read(key: key);
  //   if (json == null) return null;
  //   final decoded = jsonDecode(json) as List<dynamic>;
  //   return decoded.cast<String>();
  // }

  // // OPTIONAL HELPERS
  // static Future<void> remove(String key) async {
  //   await _storage.delete(key: key);
  // }

  // static Future<void> clear() async {
  //   await _storage.deleteAll();
  // }
}
