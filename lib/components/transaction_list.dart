// ignore_for_file: sized_box_for_whitespace

import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({Key? key, required this.transactions})
      : super(key: key);

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return Container(      
      height: 300,
      child: transactions.isEmpty ? Column(        
        children: [
          const Padding(
            padding: EdgeInsets.all(21.0),
            child: Text('Nenhuma transação cadastrada!'),
          ),
          Container(            
            height: 200,
            padding: const EdgeInsets.all(8),
            child: Image.asset('assets/images/waiting.png',
            fit: BoxFit.cover,),
          )
          ],
      ) : ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          final tr = transactions[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Card(            
              child: Row(children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Theme.of(context).colorScheme.primary,)),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'R\$ ${tr.value.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.primary,),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,                
                  children: [
                    Text(tr.title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(
                      DateFormat('d MMM y').format(tr.date),
                      style: TextStyle(color: Colors.grey[400], fontSize: 13),
                    )
                  ],
                )
              ]),
            ),
          );
        }, 
      ),
    );
  }
}
