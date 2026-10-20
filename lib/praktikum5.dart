
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contoh SizedBox',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text('Contoh SizedBox'),
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              kotakUji(Colors.amber),
              const SizedBox(
                width: 25,
              ),
              kotakUji(Colors.green),
              const SizedBox(
                width: 25,
              ),
              kotakUji(Colors.blue),
            ],
          ),
        ),
      ),
    );
  }

  Widget kotakUji(Color warna) {
    return Container(
      height: 75,
      width: 75,
      color: warna,
    );
  }
}
