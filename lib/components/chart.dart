

import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key, required this.transactions}) : super(key: key);

  final List<Transaction> transactions;

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));      
      double totalSum = 0.0;
      

      for (var i = 0; i < transactions.length; i++) {
         var transaction = transactions[i];
         bool sameDay = transaction.date.day == weekDay.day;
         bool sameMonth = transaction.date.month == weekDay.month;
         bool sameYear = transaction.date.year == weekDay.year;

         if(sameDay && sameMonth && sameYear){
          totalSum += transaction.value;
         }
      }      

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 3), 
        'value': totalSum
        };
    }).reversed.toList();
  }

  double get _weekTotalValue {

    return groupedTransactions.fold(0.0, (sum, tr){
      return sum + (tr['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    groupedTransactions;
    return Card(      
      elevation: 6,
      margin: const EdgeInsets.all(6),
      child: Row(        
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: groupedTransactions.map((transactionGroup){
          return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(
              label: transactionGroup['day'].toString(),
              value: double.parse(transactionGroup['value'].toString()),
              percentage: _weekTotalValue == 0 ? 0 : (transactionGroup['value'] as double) / _weekTotalValue,
            ),
          );
        }).toList()        
      ),
    );
  }
}