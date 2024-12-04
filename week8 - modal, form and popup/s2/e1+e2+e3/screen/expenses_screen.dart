import 'package:flutter/material.dart';
import 'package:flutter_leasson/w8/s2/e1+e2+e3//model/expense.dart';
import 'package:flutter_leasson/w8/s2/e1+e2+e3//screen/expense_list.dart';
import 'package:intl/intl.dart';
import '../widget/the_app_button.dart';

List<Expense> _registeredExpenses = [
  Expense(title: 'Dinner', amount: 30.0, dateTime: DateTime.now(), type: ExpenseType.FOOD),
  Expense(title: 'Flight', amount: 300.0, dateTime: DateTime.now(), type: ExpenseType.TRAVEL),
  Expense(title: 'Movie', amount: 15.0, dateTime: DateTime.now(), type: ExpenseType.LEISURE),
  Expense(title: 'Laptop', amount: 1000.0, dateTime: DateTime.now(), type: ExpenseType.WORK),
];

class RegisterExpense extends StatefulWidget {
  const RegisterExpense({super.key});

  @override
  State<RegisterExpense> createState() => _RegisterExpenseState();
}

class _RegisterExpenseState extends State<RegisterExpense> {
  //text field controller
  final eTitleCon = TextEditingController();
  final eAmountCon = TextEditingController();
  final eDateCon = TextEditingController();
  ExpenseType? expenseType;

  @override
  void dispose() {
    super.dispose();
    eTitleCon.dispose();
    eAmountCon.dispose();
    eDateCon.dispose();
  }

  //date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );

    //format the date when selected
    if (picked != null && picked != DateTime.now()) {
      final String formattedData = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {
        eDateCon.text = formattedData;
      });
    }
  }

  //alert dialog of error
  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Invalid Input'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Okay'),
            )
          ],
        );
      },
    );
  }

  //add expense and validation
  void addExpense() {
    final title = eTitleCon.text;
    double? amount;
    DateTime? date;

    try {
      amount = double.tryParse(eAmountCon.text);
      date = DateTime.tryParse(eDateCon.text);
    } catch (e) {
      return showErrorDialog("Invalid input format. Please check your values.");
    }

    if (title.isEmpty || amount == null || date == null || expenseType == null) {
      return showErrorDialog("Please fill all fields with valid data.");
    } else if (amount <= 0) {
      return showErrorDialog("The amount must be greater than 0.");
    } else if (date.isAfter(DateTime.now())) {
      return showErrorDialog("The date must be in the past.");
    } else {
      final newExpense = Expense(
        title: title,
        amount: amount,
        dateTime: date,
        type: expenseType!,
      );

      setState(() {
        _registeredExpenses.add(newExpense);

        //clear the text field after adding the expense
        eTitleCon.clear();
        eAmountCon.clear();
        eDateCon.clear();
        expenseType = null;
      });

      Navigator.of(context).pop();
    }
  }

  //delete function
  void onDelete(String id) {
    setState(() {
      _registeredExpenses.removeWhere((element) => element.id == id);
    });
  }

  //undo delete function
  void cancelDelete(Expense deletedExpense){
    setState(() {
      _registeredExpenses.add(deletedExpense);
    });
  }

  //cancel action function
  void cancelAction(){
    setState(() {
      eTitleCon.clear();
      eAmountCon.clear();
      eDateCon.clear();
      expenseType = null;
    });

    Navigator.of(context).pop();
  }

  //create a pop up model form
  void createExpense() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),

          child: AlertDialog(
            title: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Register your expense'),
              ],
            ),

            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                TextField(
                  maxLength: 50,
                  controller: eTitleCon,

                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.title),
                    labelText: 'Title',
                    hintText: 'Enter the title off expense',
                  ),
                ),

                const SizedBox(height: 10),

                TextField(
                  maxLength: 50,
                  controller: eAmountCon,

                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.attach_money),
                    labelText: 'Amount',
                    hintText: 'Enter the amount (0.0)',
                  ),
                ),

                const SizedBox(height: 10),

                //date picker
                TextField(
                  controller: eDateCon,

                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white24,
                    labelText: 'Date',
                    prefixIcon: Icon(Icons.calendar_today),
                    hintText: 'Select the date',

                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),

                  readOnly: true,
                  onTap: () => _selectDate(context),
                ),

                const SizedBox(height: 10),

                DropdownButtonFormField<ExpenseType>(
                  //dropdown value
                  value: expenseType,
                  onChanged: (ExpenseType? value) {
                    setState(() {
                      expenseType = value;
                    });
                  },

                  //dropdown items
                  items: ExpenseType.values.map((ExpenseType type) {
                    return DropdownMenuItem<ExpenseType>(
                      value: type,
                      child: Text(type.displayName),
                    );
                  }).toList(),

                  //dropdown decoration
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white24,
                    labelText: 'Type',
                    prefixIcon: Icon(Icons.category),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    TheAppButton(
                        label: "Cancel",
                        icon: Icons.close,
                        onTap: cancelAction
                    ),

                    const SizedBox(width: 10),

                    TheAppButton(
                      label: "Add Expense",
                      icon: Icons.check,
                      onTap: addExpense,
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your daily expenses'),
        backgroundColor: Colors.white70,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: createExpense,
          )
        ],
      ),
      body: ExpenseList(expenses: _registeredExpenses, swipeToDelete: onDelete, undoDelete: cancelDelete),
    );
  }
}

