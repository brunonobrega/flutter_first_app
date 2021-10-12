import 'package:flutter/material.dart';
import 'package:flutter_first_app/models/transfer.dart';
import 'package:flutter_first_app/screens/transfer/form.dart';

const _appBarTitle = 'Transfers';

class TransferList extends StatefulWidget {
  final List<Transfer> transfers = [];

  TransferList({Key? key}) : super(key: key);

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
        title: const Text(_appBarTitle),
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
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const TransferForm();
          })).then((receivedTransfer) {
            setState(() {
              _update(receivedTransfer);
            });
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _update(Transfer? receivedTransfer) {
    if (receivedTransfer != null) {
      widget.transfers.add(receivedTransfer);
    }
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
