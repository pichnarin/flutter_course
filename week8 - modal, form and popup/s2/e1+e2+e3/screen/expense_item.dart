  import 'package:flutter/material.dart';
  import 'package:intl/intl.dart';
  import '../model/expense.dart';

  class ExpenseItem extends StatelessWidget {
    final Expense expense;

    const ExpenseItem({super.key, required this.expense});

    @override
    Widget build(BuildContext context) {
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: ListTile(
          leading: const Icon(Icons.money, color: Colors.green),
          title: Text(
            expense.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Amount: \$${expense.amount.toStringAsFixed(2)}'),
              Text('Date: ${DateFormat('yyyy-MM-dd').format(expense.dateTime)}'),
            ],
          ),
          trailing: Text(expense.type.displayName),
        ),
      );
    }
  }