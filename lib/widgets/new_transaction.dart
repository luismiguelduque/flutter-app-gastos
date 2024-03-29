import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {

  final Function addItem;

  NewTransaction(this.addItem);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData(){
    if(_amountController.text.isEmpty){
      return;
    }
    final titleText = _titleController.text;
    final amountText = double.parse(_amountController.text);
    if(titleText.isEmpty || amountText <= 0 || _selectedDate == null){
      return;
    }

    widget.addItem(
      titleText,
      amountText,
      _selectedDate
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker(){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now()
    ).then((pickedDate){
      if(pickedDate == null){
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                controller: _titleController,
                onSubmitted: (_)=> _submitData(),
                //onChanged: (value){
                //  titleInput = value;
                //},
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                keyboardType: TextInputType.number,
                controller: _amountController,
                onSubmitted: (_)=> _submitData(),
                //onChanged: (value)=> amountInput = value,
              ),
              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(child: Text(_selectedDate == null ? "No ha seleccionado fecha" : "Fecha seleccionada: ${DateFormat.yMd().format(_selectedDate)}")),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text("Seleccione fecha", style: TextStyle(fontWeight: FontWeight.bold),),
                      onPressed: _presentDatePicker,
                    ),
                  ],
                ),
              ),
              RaisedButton(
                child: Text("Add transaction"),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: () => _submitData(),
              )
            ],
          ),
        ),
      ),
    );
  }
}