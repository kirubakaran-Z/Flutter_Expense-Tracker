import 'package:flutter/material.dart';
import 'transation_List.dart';
import '../Models/transaction.dart';

class UserTransactions extends StatefulWidget {
  List<Transaction> userTransactions;
  Function deleteTx;

  UserTransactions(this.userTransactions, this.deleteTx);

  @override
  State<UserTransactions> createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  @override
  Widget build(BuildContext context) {
    var peakcolor = Color.fromARGB(255, 61, 166, 170);
    var darkcolor = Color.fromARGB(255, 48, 47, 46);
    var lightdarkcolor = Color.fromARGB(255, 94, 95, 97);
    return TransactionList(
                transactions: widget.userTransactions,
                deleteTx: widget.deleteTx);
  }
}
