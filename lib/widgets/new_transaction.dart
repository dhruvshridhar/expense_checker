import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  Function addFxn;

  NewTransaction(this.addFxn);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleText = TextEditingController();

  final amountText = TextEditingController();

  DateTime? datefinally;

  addTransaction() {
    if (titleText.text.isNotEmpty ||
        amountText.text.isNotEmpty ||
        datefinally == null) {
      widget.addFxn(titleText.text, double.parse(amountText.text), datefinally);
    }
  }

  void showDatePick() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1990, 1, 1),
            lastDate: DateTime.now())
        .then((value) => {
              if (value == null)
                {}
              else
                {
                  setState(() {
                    datefinally = value;
                  })
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 10,
        child: Container(
          margin: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                controller: titleText,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                controller: amountText,
                keyboardType: TextInputType.number,
                onSubmitted: (val) => addTransaction(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(datefinally == null
                          ? "Select date"
                          : DateFormat.yMd().format(datefinally!).toString()),
                    ),
                    IconButton(
                        onPressed: showDatePick, icon: Icon(Icons.date_range))
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => {addTransaction()},
                child: Text(
                  "Save",
                  style: TextStyle(
                      color: Theme.of(context).textTheme.button?.color),
                ),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    primary: Theme.of(context).primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
