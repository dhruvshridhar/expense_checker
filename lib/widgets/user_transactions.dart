import 'package:expense_checker/models/transaction.dart';
import 'package:expense_checker/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

class UserTransactions extends StatelessWidget {
  final List<Transaction> _transactions;
  Function _deleteFunc;

  UserTransactions(this._transactions, this._deleteFunc);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [TransactionList(_transactions, _deleteFunc)],
    );
  }
}
