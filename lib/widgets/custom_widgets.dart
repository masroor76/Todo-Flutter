import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? myController;
  final String hintText;

  const CustomTextField({super.key, this.myController, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: myController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hintText,
      ),
    );
  }
}
