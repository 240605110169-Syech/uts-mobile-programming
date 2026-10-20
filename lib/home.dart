import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
          children: [
            Container(
              color: const Color.fromARGB(255, 246, 2, 2),
              height: 200,
              width: 200,
              child: Center(
                child: Text("alkhawarizmi"),
              ),
            ),
            Container(
              color: const Color.fromARGB(255, 2, 246, 63),
              height: 200,
              width: 200,
              child: Center(
                child: Text("UIN MALANG"),
              ),
            ),
          ],
        ),
      );
  }
}