import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double percentage;

  ChartBar(this.label, this.amount, this.percentage);

  @override
  Widget build(BuildContext context) {
    print("In ChartBar stateless widget");
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: FittedBox(child: Text("\$${amount.toStringAsFixed(0)}")),
            height: constraints.maxHeight * .15,
          ),
          SizedBox(
            height: constraints.maxHeight * .01,
          ),
          Container(
            margin: EdgeInsets.all(10),
            height: constraints.maxHeight * .5,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10)),
                ),
                FractionallySizedBox(
                  heightFactor: percentage,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * .01,
          ),
          Container(
            child: FittedBox(child: Text(label)),
            height: constraints.maxHeight * .15,
          )
        ],
      );
    });
  }
}
