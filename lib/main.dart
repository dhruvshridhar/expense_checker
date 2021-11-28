import 'package:expense_checker/widgets/chart.dart';
import 'package:expense_checker/widgets/new_transaction.dart';
import 'package:expense_checker/widgets/user_transactions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/transaction.dart';

main(List<String> args) {
  // To force app use Potrait mode
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("In myapp stateless widget");
    return MaterialApp(
      title: 'My App',
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          accentColor: Colors.amber,
          fontFamily: "OpenSans",
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(fontFamily: "OpenSans", fontSize: 20))),
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
              button: TextStyle(color: Colors.white))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyHomePage> {
  List<Transaction> _transactions = [];

  List<Transaction> get _recentTransactions {
    return _transactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  bool _showChart = false;

  void _addTransaction(String txTitle, double txAmount, DateTime dt) {
    final Transaction t =
        Transaction(DateTime.now().toString(), txTitle, txAmount, dt);
    setState(() {
      _transactions.add(t);
    });
  }

  startNewAddTransaction(
    BuildContext ctx,
  ) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addTransaction);
        });
  }

  deleteEntry(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    print("In myappstate widget");
    final bool _isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracker"),
        actions: [
          IconButton(
              onPressed: () => startNewAddTransaction(context),
              icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (_isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Show Chart?"),
                  Switch.adaptive(
                      value: _showChart,
                      onChanged: (val) => {
                            setState(() {
                              _showChart = val;
                            })
                          })
                ],
              ),
            if (!_isLandscape) Chart(_recentTransactions),
            if (!_isLandscape) UserTransactions(_transactions, deleteEntry),
            if (_isLandscape)
              _showChart
                  ? Chart(_recentTransactions)
                  : UserTransactions(_transactions, deleteEntry)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startNewAddTransaction(context),
      ),
    );
  }
}
