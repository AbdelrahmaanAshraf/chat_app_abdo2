import 'package:flutter/material.dart';

class Navigate {
  static void push(context, screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  static void pushAndReplacement(context, screen) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => screen));
  }
}