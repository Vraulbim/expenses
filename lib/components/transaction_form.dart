
import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  TransactionForm({Key? key, required this.onSubmit}) : super(key: key);

  final titleController = TextEditingController();
  final valueController = TextEditingController();  

  final void Function(String, double) onSubmit;

  @override
  Widget build(BuildContext context) {
    return Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextField(
                    controller: titleController,                  
                    decoration: const InputDecoration(
                      labelText: 'Titulo',                    
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextField(
                    controller: valueController,                    
                    decoration: const InputDecoration(
                      labelText: 'Valor (R\$)',                    
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextButton(onPressed: (){ 
                    final title = titleController.text;
                    final value = double.tryParse(valueController.text) ?? 0.0;
                    onSubmit(title, value);
                    }, child: const Text('Nova transação',
                  style: TextStyle(color: Colors.blue),)),
                )
              ],),
            ),
          );
  }
}