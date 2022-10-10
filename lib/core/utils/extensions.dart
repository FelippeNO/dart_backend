import '../../database/database_client.dart';

class ConvertTableString {
  static String getInsertionAttributesString(Table table) {
    return table.insertionAttributes.toString().replaceAll("[", "").replaceAll("]", "");
  }

  static String getInsertionValuesString(Table table) {
    String valuesString = "";
    for (var element in table.insertionAttributes) {
      valuesString = valuesString + "@" + element + ", ";
    }
    return valuesString = valuesString.substring(0, valuesString.length - 2);
  }
}
