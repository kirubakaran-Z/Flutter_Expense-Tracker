import 'package:flutter/material.dart';
import './Widgets/User_Transation.dart';
import './Widgets/new_Transaction.dart';
import './Models/transaction.dart';
import './Widgets/charts.dart';

import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'Old Shoes',
      amount: 69,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'New Shoes',
      amount: 69,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'Old Shoes',
      amount: 69,
      date: DateTime.now(),
    ),
  ];
  var peakcolor = Color.fromARGB(255, 61, 166, 170);
  var darkcolor = Color.fromARGB(255, 48, 47, 46);
  var lightdarkcolor = Color.fromARGB(255, 94, 95, 97);

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  _addNewTransaction(String txTitle, int txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddnewTransition(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              color: lightdarkcolor,
              child: NewTransaction(_addNewTransaction));
        });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Flutter App'),
      actions: [
        IconButton(
          icon: Icon(
            Icons.add,
            color: peakcolor,
          ),
          onPressed: () => _startAddnewTransition(context),
        )
      ],
      centerTitle: true,
      backgroundColor: darkcolor,
    );
    return Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
            child: Container(
          width: double.infinity,
          color: lightdarkcolor,
          child: Column(
            children: <Widget>[
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.4,
                child: Charts(_recentTransactions),
              ),
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.6,
                child: UserTransactions(_userTransactions, _deleteTransaction),
              ),
            ],
          ),
        )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () => _startAddnewTransition(context),
          child: Icon(Icons.add, color: peakcolor),
          backgroundColor: darkcolor,
        ));
  }
}
