import 'package:expenses/components/transaction_user.dart';
import 'package:flutter/material.dart';

main(){
  runApp(const ExpansesApp());
}

class ExpansesApp extends StatelessWidget {
  const ExpansesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);
      

  @override
  Widget build(BuildContext context) {
    return  Scaffold(    
      appBar: AppBar(title: const Text('Despesas App'),),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,        
          children: const <Widget>[
             Card(
               color: Colors.blue,
               elevation: 5,            
               child: Text('Gráfico'),
             ),
             TransactionUser()       
          ],
        ),
      )
      );    
  }
}