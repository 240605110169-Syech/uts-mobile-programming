import 'package:flutter/material.dart';

class Tujuan2 extends StatelessWidget {
  const Tujuan2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Halaman Tujuan Dua")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Ini adalah halaman Tujuan dua",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                side: const BorderSide(width: 1.0, color: Colors.blue),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Kembali ke Home",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
