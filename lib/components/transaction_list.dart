import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({Key? key, required this.transactions, required this.onRemove})
      : super(key: key);

  final List<Transaction> transactions;
  final void Function(String) onRemove;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: transactions.isEmpty
          ? Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(21.0),
                  child: Text('Nenhuma transação cadastrada!'),
                ),
                Container(
                  height: 200,
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                final tr = transactions[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Card(
                    elevation: 7,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Theme.of(context).colorScheme.primary,                      
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            height: 20,
                            child: FittedBox(
                                child: Text(
                                    'R\$ ${tr.value.toStringAsFixed(2).replaceAll('.', ',')}',
                                    style: const TextStyle(
                                      fontSize: 16
                                    ),)),
                          ),
                        ),
                      ),
                      title: Text(tr.title,
                          style: TextStyle(                            
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.primary,
                          )),
                      subtitle: Text(DateFormat('d MMM y').format(tr.date),
                      style: const TextStyle(
                        fontSize: 13                        
                      ),
                      ),
                      trailing: IconButton(icon: const Icon(Icons.delete), color : Theme.of(context).colorScheme.primary, onPressed: () => {onRemove(tr.id)},)                      
                    ),
                  ),
                );
              },
            ),
    );
  }
}
