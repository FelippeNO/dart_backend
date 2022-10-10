void main() {
  List<String> _insertionAttributes = ["number1", "number2", "multiply"];
  String buffer = "";

  for (var element in _insertionAttributes) {
    buffer = buffer + "@" + element + ", ";
  }

  buffer = buffer.substring(0, buffer.length - 2);
  print(buffer);
}
