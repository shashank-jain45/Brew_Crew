import 'package:flutter/material.dart';

class TextFormFieldDecoration {
  final String lableName;
  InputDecoration? textInputDecoration;
  TextFormFieldDecoration({required this.lableName}) {
    textInputDecoration = InputDecoration(
      label: Text(lableName),
      fillColor: Colors.white,
      filled: true,
      contentPadding: const EdgeInsets.all(12.0),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2.0),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.pink, width: 2.0),
      ),
    );
  }
}
