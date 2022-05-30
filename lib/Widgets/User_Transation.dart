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
    return TransactionList(
        transactions: widget.userTransactions, deleteTx: widget.deleteTx);
  }
}
