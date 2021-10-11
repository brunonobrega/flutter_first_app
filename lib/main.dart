import 'package:flutter/material.dart';

void main() {
  runApp(BankApp());
}

class BankApp extends StatelessWidget {
  const BankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        body: TransferForm(),
      ),
    );
  }
}

class TransferForm extends StatelessWidget {

  final TextEditingController inputControllerAccount = TextEditingController();
  final TextEditingController inputControllerValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Make a Transfer'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: inputControllerAccount,
              style: const TextStyle(fontSize: 24.0),
              decoration: const InputDecoration(
                  labelText: 'Account Number', hintText: '0000'),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: inputControllerValue,
              style: const TextStyle(fontSize: 24.0),
              decoration: const InputDecoration(
                  icon: Icon(Icons.monetization_on),
                  labelText: 'Value',
                  hintText: '0.00'),
              keyboardType: TextInputType.number,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              debugPrint('Clicou');
              final int? account = int.tryParse(inputControllerAccount.text);
              final double? value = double.tryParse(inputControllerValue.text);
              if(account != null && value != null) {
                final makeTransfer = Transfer(value, account);
                debugPrint('$makeTransfer');
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('$makeTransfer'),
                  duration: const Duration(seconds: 2),
                  // action: SnackBarAction(
                  //   label: 'ACTION',
                  //   onPressed: () { },
                  // ),
                ));
              }
            },
            child: const Text('Confirm Transfer'),
          ),
        ],
      ),
    );
  }
}

class TransferList extends StatelessWidget {
  const TransferList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfers'),
      ),
      body: Column(
        children: [
          TransferItem(
              transfer: Transfer(100.0, 1000)),
          TransferItem(
              transfer: Transfer(200.0, 1001)),
          TransferItem(
              transfer: Transfer(400.0, 2000)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
