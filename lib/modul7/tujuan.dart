import 'package:app_baru/modul7/screen_arguments.dart';
import 'package:flutter/material.dart';

import 'tujuan2.dart';

class Tujuan extends StatelessWidget {
  const Tujuan({super.key});

  @override
  Widget build(BuildContext context) {
    final data =ModalRoute.of(context)!.settings.arguments as ScreenArguments;
   
    return Scaffold(
      appBar: AppBar(title: const Text("Halaman Tujuan")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Ini adalah halaman Tujuan ${data.title}",
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
            SizedBox(height: 50),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                side: const BorderSide(width: 1.0, color: Colors.blue),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Tujuan2()),
                );
              },
              child: const Text(
                "Ke Tujuan Dua",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
