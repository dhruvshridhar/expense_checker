import 'package:expense_checker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../transactionCard.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> _transactions = [];
  Function _deleteFunc;

  TransactionList(this._transactions, this._deleteFunc);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.8,
        child: _transactions.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    Text(
                      "No transactions added yet!",
                      style: Theme.of(context).textTheme.title,
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      height: 200,
                      child: Image.asset(
                        "assets/images/waiting.png",
                        fit: BoxFit.cover,
                      ),
                    )
                  ])
            : ListView.builder(
                itemCount: _transactions.length,
                itemBuilder: (ctx, index) {
                  //return TransactionCard(_transactions[index]);
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        child: Padding(
                          padding: EdgeInsets.all(1),
                          child: FittedBox(
                              child: Text(
                            "\$${_transactions[index].amount}",
                          )),
                        ),
                      ),
                      title: Text(
                        _transactions[index].title,
                        style: Theme.of(context).textTheme.title,
                      ),
                      subtitle: Text(
                          DateFormat.yMMMd().format(_transactions[index].date)),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deleteFunc(_transactions[index].id);
                        },
                        color: Theme.of(context).errorColor,
                      ),
                    ),
                  );
                }));
  }
}
