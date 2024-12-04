import 'package:uuid/uuid.dart';
enum ExpenseType { FOOD, TRAVEL, LEISURE, WORK }

extension ExpenseTypeExtension on ExpenseType {
  String get displayName {
    switch (this) {
      case ExpenseType.FOOD:
        return "Food";
      case ExpenseType.TRAVEL:
        return "Travel";
      case ExpenseType.LEISURE:
        return "Leisure";
      case ExpenseType.WORK:
        return "Work";
    }
  }
}


class Expense{

  var uuid = const Uuid();

  final String id;
  final String title;
  final double amount;
  final DateTime dateTime;
  final ExpenseType type;

  Expense({required this.title, required this.amount, required this.dateTime, required this.type, String? id})
      : id = const Uuid().v4();
}

void main(){
  var expense = Expense(title: 'Lunch', amount: 20.0, dateTime: DateTime.now(), type: ExpenseType.FOOD);
  var expense2 = Expense(title: 'Dinner', amount: 30.0, dateTime: DateTime.now(), type: ExpenseType.FOOD);
  print(expense.id);
}