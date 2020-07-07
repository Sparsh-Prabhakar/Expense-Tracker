import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = _amountController.text;

    if (enteredTitle.isEmpty || enteredAmount.isEmpty || _selectedDate == null) {
      return;
    }

    widget.addTx(
      _titleController.text,
      double.parse(_amountController.text),
      _selectedDate
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              controller: _titleController,
              // onChanged: (value) {
              //   titleInput = value;
              // }, //dart will automatically know this will be only a String
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              controller: _amountController,
              keyboardType: TextInputType
                  .number, //for ios use TextInputType.numberWithOptons(decimal: true)
              onSubmitted: (_) => _submitData(),
              // onChanged: (value) {
              //   amountInput = value;
              // },
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: Text(_selectedDate == null
                        ? 'No Date Chosen'
                        : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}')),
                Container(
                  height: 70,
                  child: FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: _presentDatePicker,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            RaisedButton(
              onPressed: _submitData,
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              child: Text(
                'Add Transaction',
              ),
            )
          ],
        ),
      ),
    );
  }
}