import 'package:flutter/material.dart';
import '../model/expense.dart';
import 'expense_item.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;
  final Function(String) swipeToDelete;
  final Function(Expense) undoDelete;

  const ExpenseList({super.key, required this.expenses, required this.swipeToDelete,required this.undoDelete});

  @override
  Widget build(BuildContext context) {
    return expenses.isEmpty ? buildEmptyList() : buildExpenseList(expenses, swipeToDelete, undoDelete);
  }
}

//if there is an list of expenses, then build the list of expenses
Widget buildExpenseList(List<Expense> expenses, Function(String) swipeToDelete, Function(Expense) undoDelete) {
  return ListView.builder(
    itemCount: expenses.length,
    itemBuilder: (context, index) {
      final expense = expenses[index];

      return Dismissible(
          key: ValueKey(expense.id),
          direction: DismissDirection.startToEnd,
          onDismissed: (direction) {
            swipeToDelete(expense.id);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Delete ${expense.title} successfully.'),
                action: SnackBarAction(
                    label: 'Undo',
                    onPressed: (){
                      undoDelete(expense);
                    }
                ),
              )
            );
          },

        background: Container(
          color: Colors.black,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),

        child: ExpenseItem(expense: expense),
      );
    },
  );
}

//if there is no expenses, then show a message
Widget buildEmptyList() {
  return const Center(
    child: Text(
      'No expenses registered',
      style: TextStyle(fontSize: 18),
    ),
  );
}

