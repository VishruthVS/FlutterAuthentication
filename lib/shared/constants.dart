import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Color.fromARGB(255, 150, 184, 202),
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color.fromARGB(255, 150, 184, 202),
      width: 2.0,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white54,
      width: 2.0,
    ),
  ),
);
