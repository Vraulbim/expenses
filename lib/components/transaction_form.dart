
// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({Key? key, required this.onSubmit}) : super(key: key);

  final void Function(String, double, DateTime) onSubmit;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();  

  _submitForm(){    
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if(title.isEmpty || value <= 0){
      return;
    }   

    widget.onSubmit(title, value, _selectedDate);
                    
  }

  _showDatePicker(){
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2019), lastDate: DateTime.now()).then((date) {
      if(date == null){
        return;
      }

      setState(() {
        _selectedDate = date;
      });      
    });
  }

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
                    onSubmitted: (_) => _submitForm(),             
                    decoration: const InputDecoration(
                      labelText: 'Titulo',                    
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextField(
                    controller: valueController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    onSubmitted: (_) => _submitForm(),
                    decoration: const InputDecoration(
                      labelText: 'Valor (R\$)',                    
                    )
                  ),
                ),
                Padding(padding: const EdgeInsets.all(10),
                child: Text( _selectedDate == null ? 'Nenhuma data selecionada!' : DateFormat('dd/MM/y').format(_selectedDate)),),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Expanded(child: TextButton(onPressed: _showDatePicker,  child: const Text('Selecionar Data'))),
                ),
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: ElevatedButton(onPressed: _submitForm, child: const Text('Nova transação',
                  style: TextStyle(color: Colors.white,),)),
                )
              ],),
            ),
          );
  }
}