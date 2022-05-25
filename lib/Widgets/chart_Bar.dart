import 'package:flutter/material.dart';

class ChatBar extends StatelessWidget {
  final String label;
  final int spendingAmount;
  final double percentofTotal;

  ChatBar(
      {required this.label,
      required this.spendingAmount,
      required this.percentofTotal});

  @override
  var peakcolor = Color.fromARGB(255, 61, 166, 170);
  var lightdarkcolor = Color.fromARGB(255, 94, 95, 97);
  var darkcolor = Color.fromARGB(255, 48, 47, 46);

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FittedBox(child: Text('${spendingAmount.toString()}')),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 100,
          width: 20,
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                color: lightdarkcolor,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            FractionallySizedBox(
              heightFactor: percentofTotal,
              child: Container(
                decoration: BoxDecoration(
                  color: darkcolor,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ]),
        ),
        SizedBox(
          height: 10,
        ),
        Text(label),
      ],
    );
  }
}
