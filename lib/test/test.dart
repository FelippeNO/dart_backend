import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';

import '../core/error/table_integrity_exceptions.dart';
import '../core/models/table.dart';
import '../numbers_module/data/infraestructure/tables/numbers_table.dart';

void main() {
  var bytes = utf8.encode("123456"); // data being hashed

  var digest = sha256.convert(bytes);
  print("Digest as bytes: ${digest.bytes}");
  print(digest.toString()); // YOUR_ENCRYPTED_STRING
}
