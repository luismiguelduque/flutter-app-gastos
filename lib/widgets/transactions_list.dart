import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:witgets/models/transaction.dart';


class TransactionsList extends StatelessWidget {

  final List<Transaction> _userTransactions;
  final Function deleteTransaction;

  TransactionsList(this._userTransactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return _userTransactions.isEmpty
      ? LayoutBuilder(
        builder: (context, constrints){
          return Column(
            children: <Widget>[
              Text("No se ha agregado ninguna transaccion", style: Theme.of(context).textTheme.title,),
              SizedBox(height: 10,),
              Container(
                height: constrints.maxHeight * 0.6,
                child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover,)
              ),
            ],
          );
        },
      )
      : ListView.builder(
        itemCount: _userTransactions.length,
        itemBuilder: (context, index){
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: FittedBox(
                    child: Text('\$${_userTransactions[index].amount.toStringAsFixed(2)}'),
                  ),
                )
              ),
              title: Text(_userTransactions[index].title, style: Theme.of(context).textTheme.title,),
              subtitle: Text(DateFormat.yMMMd().format(_userTransactions[index].date)),
              trailing: MediaQuery.of(context).size.width > 360
                ? FlatButton.icon(
                  icon: Icon(Icons.delete),
                  label: Text("Delete"),
                  textColor: Theme.of(context).errorColor,
                  onPressed: () => deleteTransaction(_userTransactions[index].id),
                )
                : IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () => deleteTransaction(_userTransactions[index].id),
                ),
            ),
          );
        },
      );
  }
}