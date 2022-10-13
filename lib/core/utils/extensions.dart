import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';

import '../error/table_integrity_exceptions.dart';
import '../models/table.dart';

class ConvertTableString {
  static String getInsertionAttributesString(Table table) {
    return table.insertionAttributes.toString().replaceAll("[", "").replaceAll("]", "");
  }

  static String getInsertionValuesString(Table table) {
    String valuesString = "";
    for (var element in table.insertionAttributes) {
      valuesString = "$valuesString@$element, ";
    }
    return valuesString = valuesString.substring(0, valuesString.length - 2);
  }

  static String getEntityAttributesValuesString(Table table) {
    return table.entityAttributes.toString().replaceAll("[", "").replaceAll("]", "");
  }
}

class TableModelIntegrity {
  static bool verify(Table table) {
    if (table.primaryKey.isEmpty) throw EmptyPrimaryKeyException;
    if (table.tableName.isEmpty) throw EmptyTableNameException;
    if (table.entityAttributes.contains(table.primaryKey)) {
      if (table.insertionAttributes.length <= table.entityAttributes.length) {
        for (var item in table.insertionAttributes) {
          if (table.entityAttributes.contains(item)) {
            return true;
          }
          throw EntityDoNotContainInsertionAttributeException;
        }
      }
      throw InsertionHasMoreAttributesThanEntityException;
    }
    throw EntityDoNotContainPrimaryKeyNameException;
  }
}

class CoreKeys {
  static String generateUUID() {
    final uuid = Uuid();
    String newUserId = uuid.v4();
    return newUserId;
  }

  static String hashPassword(String password) {
    var bytes = utf8.encode(password); // data being hashed
    var digest = sha256.convert(bytes);
    return digest.toString();
  }
}
