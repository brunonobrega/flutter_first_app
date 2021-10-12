import 'package:flutter/material.dart';
import 'package:flutter_first_app/components/editor.dart';
import 'package:flutter_first_app/models/transfer.dart';

const _appBarTitle = 'Make a Transfer';

const _labelInputAccount = 'Account Number';
const _placeHolderAccount = '0000';

const _labelInputValue = 'Value';
const _placeHolderValue = '0.00';

const _textConfirmButton = 'Confirm Transfer';

class TransferForm extends StatefulWidget {
  const TransferForm({Key? key}) : super(key: key);

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
        title: const Text(_appBarTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
              controller: inputControllerAccount,
              inputLabel: _labelInputAccount,
              placeHolder: _placeHolderAccount,
            ),
            Editor(
              controller: inputControllerValue,
              inputLabel: _labelInputValue,
              placeHolder: _placeHolderValue,
              icon: Icons.monetization_on,
            ),
            ElevatedButton(
              onPressed: () {
                _createTransfer(context);
              },
              child: const Text(_textConfirmButton),
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
