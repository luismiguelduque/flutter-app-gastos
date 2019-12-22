import 'package:flutter/material.dart';
import 'package:witgets/widgets/new_transaction.dart';
import 'package:witgets/widgets/transactions_list.dart';

import 'models/transaction.dart';
import 'widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight:
            FontWeight.bold
          ),
          button: TextStyle(
            color: Colors.white
          )
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(title: TextStyle(fontFamily: 'OpenSans', fontSize: 20, fontWeight: FontWeight.bold))
        )
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {

  //String titleInput='';
  //String amountInput='';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _userTransactions=[
    /* Transaction(
      id: 't1',
      title: 'New shoes',
      amount: 69.99, date:
      DateTime.now()
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 16.53, date:
      DateTime.now()
    ), */
  ];

  List<Transaction> get _recentTransacction {
    return _userTransactions.where((item){
      return item.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime selectedDate){
    final newItem = Transaction(
      title: title,
      amount: amount,
      date: selectedDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newItem);
    });
  }

  void _startAddNewTransaction(BuildContext context){
    showModalBottomSheet(
      context: context,
      builder: (context){
        return GestureDetector(
          onTap: (){},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      }
    );
  }

  void deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((item) => item.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Expenses"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: ()=> _startAddNewTransaction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Chart(_recentTransacction),
            TransactionsList(_userTransactions, deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context)
      ),
    );
  }
}