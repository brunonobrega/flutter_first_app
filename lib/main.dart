import 'package:flutter/material.dart';
import 'package:flutter_first_app/screens/transfer/list.dart';

void main() {
  runApp(const BankApp());
}

class BankApp extends StatelessWidget {
  const BankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.grey[800],
          secondary: Colors.redAccent,
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.redAccent[200],
          textTheme: ButtonTextTheme.primary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
          ),
        ),
      ),
      home: TransferList(),
    );
  }
}
