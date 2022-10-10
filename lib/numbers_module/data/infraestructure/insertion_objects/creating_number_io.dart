import '../../../../core/models/insertion_object.dart';

class CreatingNumber<NumbersTable> extends InsertionObject {
  final int number1;
  final int number2;
  final int multiply;

  static Type get type => CreatingNumber;

  CreatingNumber({
    required this.number1,
    required this.number2,
    required this.multiply,
  });

  @override
  Map<String, dynamic> get insertionMap => {
        "number1": number1,
        "number2": number2,
        "multiply": multiply,
      };
}
