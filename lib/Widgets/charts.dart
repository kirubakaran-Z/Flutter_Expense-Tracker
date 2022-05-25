import 'package:flutter/material.dart';
import '../Models/transaction.dart';
import 'package:intl/intl.dart';
import 'chart_Bar.dart';

class Charts extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Charts(this.recentTransactions);
  List<Map<String, Object>> get groupedTransitionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  num get totalspending {
    return groupedTransitionValues.fold(0, (sum, item) {
      return sum + int.parse(item['amount'].toString());
    });
  }

  var peakcolor = Color.fromARGB(255, 61, 166, 170);
  var lightdarkcolor = Color.fromARGB(255, 138, 140, 143);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(20),
        elevation: 6,
        color: lightdarkcolor,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransitionValues.map((e) {
              return Flexible(
                  fit: FlexFit.tight,
                  child: ChatBar(
                      label: e['day'].toString(),
                      spendingAmount: int.parse(e['amount'].toString()),
                      percentofTotal: totalspending == 0
                          ? 0
                          : int.parse(e['amount'].toString()) / totalspending));
            }).toList(),
          ),
        ));
  }
}
