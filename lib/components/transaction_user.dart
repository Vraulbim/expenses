import 'dart:math';

import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({Key? key}) : super(key: key);

  @override
  State<TransactionUser> createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  final _transactions = [
    Transaction(
        id: 't1', title: 'Playstation 5', date: DateTime.now(), value: 5560.00)
  ];

  _addTransaction(String title, double value){
    final newTransaction = Transaction(id: Random().nextDouble().toString(), 
    title: title, 
    value: value, 
    date: DateTime.now());

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionForm(onSubmit: _addTransaction,),
        TransactionList(transactions: _transactions),
      ],
    );
  }
}
