import 'package:flutter/material.dart';

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