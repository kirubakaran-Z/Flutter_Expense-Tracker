import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart' as tx;

class TransactionList extends StatelessWidget {
  var peakcolor = Color.fromARGB(255, 61, 166, 170);
  var darkcolor = Color.fromARGB(255, 48, 47, 46);
  var lightdarkcolor = Color.fromARGB(255, 94, 95, 97);

  final List transactions;
  Function deleteTx;

  TransactionList({required this.transactions, required this.deleteTx});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: TextStyle(color: peakcolor, fontSize: 20),
                ),
                Container(
                    child: Image.asset(
                  'Assets/images/waiting.png',
                  fit: BoxFit.contain,
                )),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Container(
                    width: double.infinity,
                    child: (Card(
                      color: peakcolor,
                      child: Row(children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: lightdarkcolor, width: 2),
                              borderRadius: BorderRadius.circular(15)),
                          child: Text(
                            '${transactions[index].amount} ₹',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: lightdarkcolor),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                transactions[index].title,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: darkcolor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                DateFormat.yMMMd()
                                    .format(transactions[index].date),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: lightdarkcolor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: darkcolor,
                            ),
                            onPressed: () {
                              deleteTx(transactions[index].id);
                            },
                          ),
                        )
                      ]),
                    )));
              },
              itemCount: transactions.length,
            ),
    );
  }
}
