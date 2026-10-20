import 'dart:io';

import 'package:app_baru/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyWidget());
}
 class MyWidget extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
