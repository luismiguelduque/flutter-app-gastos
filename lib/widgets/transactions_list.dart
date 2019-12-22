import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:witgets/models/transaction.dart';


class TransactionsList extends StatelessWidget {

  final List<Transaction> _userTransactions;
  final Function deleteTransaction;

  TransactionsList(this._userTransactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      child: _userTransactions.isEmpty ? Column( children: <Widget>[
          Text("No se ha agregado ninguna transaccion", style: Theme.of(context).textTheme.title,),
          SizedBox(height: 10,),
          Container(
            height: 200,
            child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover,)
          ),
        ],) : ListView.builder(
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
              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => deleteTransaction(_userTransactions[index].id),
              ),
            ),
          );
         /*  return Card(
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor, width: 2),
                  ),
                  child: Text('\$${_userTransactions[index].amount.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Theme.of(context).primaryColor),),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(_userTransactions[index].title, style: Theme.of(context).textTheme.title,),
                    Text(
                      DateFormat.yMMMMd("en_US").format(_userTransactions[index].date),
                      style: TextStyle(fontSize: 15, color: Colors.grey)
                    ),
                  ],
                )
              ],
            ),
          ); */
        },
      ),
    );
  }
}