import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _addtx;

  NewTransaction(this._addtx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = int.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget._addtx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    _titleController.clear();
    _amountController.clear();
    Navigator.of(context).pop();
  }

  _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    const peakcolor = Color.fromARGB(255, 61, 166, 170);
    const darkcolor = Color.fromARGB(255, 48, 47, 46);
    const lightdarkcolor = Color.fromARGB(255, 94, 95, 97);
    return Card(
        elevation: 5,
        color: lightdarkcolor,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                  style: TextStyle(color: peakcolor, fontSize: 18),
                  controller: _titleController,
                  onSubmitted: (_) => _submitData(),
                  decoration: InputDecoration(
                    labelText: 'Title',
                  )),
              TextField(
                style: TextStyle(color: peakcolor, fontSize: 18),
                controller: _amountController,
                onSubmitted: (_) => _submitData(),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(children: <Widget>[
                  Expanded(
                    child: Text(_selectedDate == null
                        ? 'No Date Chosen!'
                        : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}'),
                  ),
                  TextButton(
                      onPressed: _presentDatePicker, child: Text('Choose Date'))
                ]),
              ),
              Container(
                  margin: EdgeInsets.all(30),
                  child: ElevatedButton(
                    onPressed: _submitData,
                    child: Text(
                      'Add Transaction',
                      style: TextStyle(color: darkcolor),
                    ),
                  )),
            ],
          ),
        ));
  }
}
