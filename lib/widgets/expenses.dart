import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Flutter Course',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Cinema',
        amount: 15.69,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: onAddExpense),
    );
  }
// funcion que añade expensas, utiliza la clase Expense q tiene definido el modelo, Los datos vienen en la funcion onAddExpenses.
  void onAddExpense(Expense expense) { 
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void onRemoveExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars(); // hace que el mensaje de alerta de elemento borrado desaparezca al instante si se borra otro.
    ScaffoldMessenger.of(context).showSnackBar( // elemento que muestra un snack bar con diferentes elementos dentro
      SnackBar(
        duration: const Duration(seconds: 5),
        content: const Text('Gasto borrado'),
        action: SnackBarAction( // setea un boton en el snackbar que hace lo q esta en onpressed
          label: 'Desacer',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense); // toma el elemento y su index(el cual definimos arriba en expense index) y lo reinserta en el mismo lugar donde estaba
            });
          },

        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center( // definimos que pantalla mostrar si no hay datos
      child: Text('No tiene gastos registrados!'),
    );

    if (_registeredExpenses.isNotEmpty) { // condicional sobre q pantalla mostrar.
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: onRemoveExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appbar Flutter'),
        toolbarHeight: 50,
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [Chart(expenses: _registeredExpenses), Expanded(child: mainContent)],
      ),
    );
  }
}
