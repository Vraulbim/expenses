import 'dart:math';

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/material.dart';

import 'components/transaction_list.dart';
import 'models/transaction.dart';

main() {
  runApp(ExpansesApp());
}

class ThemeHelper {
  bool darkMode = false;
  static ThemeHelper instance = ThemeHelper();

  static updateTheme() {
    instance.darkMode = !instance.darkMode;
  }
}

class ExpansesApp extends StatefulWidget {
  const ExpansesApp({Key? key}) : super(key: key);

  @override
  State<ExpansesApp> createState() => _ExpansesAppState();
}

class _ExpansesAppState extends State<ExpansesApp> {
  final ThemeData theme = ThemeData();

  _updateTheme() {
    setState(() {
      ThemeHelper.instance.darkMode = !ThemeHelper.instance.darkMode;      
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(
        updateTheme: () => _updateTheme(),
      ),
      theme: ThemeHelper.instance.darkMode == false
          ? theme.copyWith(
              colorScheme: theme.colorScheme
                  .copyWith(primary: Colors.blue, secondary: Colors.blue[300]),
              textTheme: theme.textTheme.copyWith(
                  headline6: const TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                  bodyText1: const TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                  bodyText2: const TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)))
          : theme.copyWith(
              scaffoldBackgroundColor: Colors.black54,
              cardTheme: const CardTheme(
                color: Colors.black54
              ),
              colorScheme: const ColorScheme.dark().copyWith(
                  primary: Colors.blue, secondary: Colors.blue[300], background: Colors.black54),
              textTheme: theme.textTheme.copyWith(                
                  headline6: const TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                  bodyText1: const TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  bodyText2: const TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.updateTheme}) : super(key: key);

  void Function() updateTheme;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
        id: 't1',
        title: 'Playstation 5',
        date: DateTime.now().subtract(const Duration(days: 3)),
        value: 200.00)
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((t) {
      return t.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: DateTime.now());

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(onSubmit: _addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PayFinance'),
        actions: [
          IconButton(
              onPressed: widget.updateTheme, icon: ThemeHelper.instance.darkMode ? const Icon(Icons.dark_mode_outlined) : const Icon(Icons.dark_mode)),
          IconButton(
            onPressed: () => _openTransactionFormModal(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(transactions: _recentTransactions),
            TransactionList(transactions: _transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _openTransactionFormModal(context),
          child: const Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
