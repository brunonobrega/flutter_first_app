import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: const TransferList(),
      appBar: AppBar(
        title: const Text('Transferências'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    ),
  ));
}

class TransferList extends StatelessWidget {
  const TransferList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        TransferItem(transfer: Transfer(
            transferValue: 100.0,
            accountNumber: 1000)
        ),
        TransferItem(transfer: Transfer(
            transferValue: 200.0,
            accountNumber: 1001)
        ),
        TransferItem(transfer: Transfer(
            transferValue: 400.0,
            accountNumber: 2000)
        ),
      ],
    );
  }
}

class TransferItem extends StatelessWidget {
  final Transfer transfer;

  const TransferItem({Key? key, required this.transfer})
      : super(key: key);

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

class Transfer extends StatelessWidget {
  final double transferValue;
  final int accountNumber;

  const Transfer(
      {Key? key, required this.transferValue, required this.accountNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}
