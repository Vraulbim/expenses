import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({Key? key, required this.label, required this.value, required this.percentage}) : super(key: key);

  final String label;
  final double value;
  final double percentage;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      Container(
        padding: EdgeInsets.all(8),
        height: 30,
        child: FittedBox(
          child: Text(
            'R\$${value.toStringAsFixed(2).replaceAll('.', ',')}',
            style: const TextStyle(
              fontSize: 20
            ),
            ),
        ),
      ),
      SizedBox(
        height: 60, 
        width: 10,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(                            
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1
                ),
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(2)
              ),
            ),
            FractionallySizedBox(
              heightFactor: percentage,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(2)
                ),
              ),
            )
          ],
        )
      ),      
      Text(label, style: const TextStyle(fontSize: 10),)
    ],);
  }
}