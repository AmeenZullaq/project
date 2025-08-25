import 'dart:convert';
import 'package:crypto/crypto.dart';

String hashString(String input) {
  // Convert string to bytes
  List<int> bytes = utf8.encode(input);

  // Generate SHA-256 hash
  Digest digest = sha256.convert(bytes);

  // Convert to hex string
  return digest.toString();
}

String hashStringMD5(String input) {
  // Convert string to bytes
  List<int> bytes = utf8.encode(input);

  // Generate MD5 hash
  Digest digest = md5.convert(bytes);

  // Convert to hex string
  return digest.toString();
}

String hashStringSHA1(String input) {
  // Convert string to bytes
  List<int> bytes = utf8.encode(input);

  // Generate SHA-1 hash
  Digest digest = sha1.convert(bytes);

  // Convert to hex string
  return digest.toString();
}

String hashStringSHA256(String input) {
  // Convert string to bytes
  List<int> bytes = utf8.encode(input);

  // Generate SHA-256 hash
  Digest digest = sha256.convert(bytes);

  // Convert to hex string
  return digest.toString();
}

String hashStringSHA384(String input) {
  // Convert string to bytes
  List<int> bytes = utf8.encode(input);

  // Generate SHA-384 hash
  Digest digest = sha384.convert(bytes);

  // Convert to hex string
  return digest.toString();
}

String hashStringSHA512(String input) {
  // Convert string to bytes
  List<int> bytes = utf8.encode(input);

  // Generate SHA-512 hash
  Digest digest = sha512.convert(bytes);

  // Convert to hex string
  return digest.toString();
}
