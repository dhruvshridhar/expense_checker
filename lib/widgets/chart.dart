import 'dart:ffi';

import 'package:expense_checker/models/transaction.dart';
import 'package:expense_checker/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;

  Chart(this.transactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;

      for (var i = 0; i < transactions.length; i++) {
        if (transactions[i].date.day == weekDay.day &&
            transactions[i].date.month == weekDay.month &&
            transactions[i].date.year == weekDay.year) {
          totalSum += transactions[i].amount;
        }
      }

      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    });
  }

  double get maxSpending {
    return groupedTransactionValues.fold(
        0,
        (previousValue, element) =>
            previousValue + double.parse(element['amount'].toString()));
  }

  @override
  Widget build(BuildContext context) {
    print("In Chart stateless widget");
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.2,
      child: Card(
          elevation: 6,
          margin: EdgeInsets.all(10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: groupedTransactionValues
                  .map((e) => Flexible(
                        fit: FlexFit.tight,
                        child: ChartBar(
                            e['day'].toString(),
                            double.parse(e['amount'].toString()),
                            maxSpending == 0
                                ? 0
                                : double.parse(e['amount'].toString()) /
                                    maxSpending),
                      ))
                  .toList())),
    );
  }
}
