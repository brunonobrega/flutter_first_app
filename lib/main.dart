import 'package:flutter/material.dart';

void main() {
  runApp(BankApp());
}

class BankApp extends StatelessWidget {
  const BankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSwatch().copyWith(primary: Colors.grey[800], secondary: Colors.redAccent),
        buttonTheme: ButtonThemeData(
            buttonColor: Colors.redAccent[200],
            textTheme: ButtonTextTheme.primary),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent)
          )
        )
      ),
      home: TransferList(),
    );
  }
}

class TransferForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TransferFormState();
  }
}

class TransferFormState extends State<TransferForm> {
  final TextEditingController inputControllerAccount = TextEditingController();
  final TextEditingController inputControllerValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Make a Transfer'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
                controller: inputControllerAccount,
                inputLabel: 'Account Number',
                placeHolder: '0000'),
            Editor(
                controller: inputControllerValue,
                inputLabel: 'Value',
                placeHolder: '0.00',
                icon: Icons.monetization_on),
            ElevatedButton(
              onPressed: () {
                _createTransfer(context);
              },
              child: const Text('Confirm Transfer'),
            ),
          ],
        ),
      ),
    );
  }

  void _createTransfer(BuildContext context) {
    final int? account = int.tryParse(inputControllerAccount.text);
    final double? value = double.tryParse(inputControllerValue.text);
    if (account != null && value != null) {
      final makeTransfer = Transfer(value, account);
      debugPrint('Creating Transfer');
      debugPrint('$makeTransfer');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$makeTransfer'),
        duration: const Duration(seconds: 2),
        // action: SnackBarAction(
        //   label: 'ACTION',
        //   onPressed: () { },
        // ),
      ));
      Navigator.pop(context, makeTransfer);
    }
  }
}

class Editor extends StatelessWidget {
  final TextEditingController controller;
  final String inputLabel;
  final String placeHolder;
  final IconData? icon;

  const Editor({
    Key? key,
    required this.controller,
    required this.inputLabel,
    required this.placeHolder,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
            icon: icon != null ? Icon(icon) : null,
            labelText: inputLabel,
            hintText: placeHolder),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class TransferList extends StatefulWidget {
  final List<Transfer> transfers = [];

  @override
  State<StatefulWidget> createState() {
    return TransferListState();
  }
}

class TransferListState extends State<TransferList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfers'),
      ),
      body: ListView.builder(
        itemCount: widget.transfers.length,
        itemBuilder: (context, index) {
          final transferList = widget.transfers[index];
          return TransferItem(
            transfer: transferList,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final Future<Transfer?> future =
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return TransferForm();
          }));
          future.then((receivedTransfer) {
            debugPrint('Arrived on Future');
            debugPrint('$receivedTransfer');
            setState(() {
              if (receivedTransfer != null) {
                widget.transfers.add(receivedTransfer);
              }
            });
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TransferItem extends StatelessWidget {
  final Transfer transfer;

  const TransferItem({Key? key, required this.transfer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.monetization_on),
        title: Text(transfer.transferValue.toString()),
        subtitle: Text(transfer.accountNumber.toString()),
      ),
    );
  }
}

class Transfer {
  final double transferValue;
  final int accountNumber;

  // const Transfer(
  //     {Key? key, required this.transferValue, required this.accountNumber})
  //     : super(key: key);
  Transfer(this.transferValue, this.accountNumber);

  @override
  String toString() {
    return ' Transfer{ value: $transferValue, account: $accountNumber }';
  }
}
