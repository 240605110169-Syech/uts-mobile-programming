import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screen_arguments.dart';

class Tujuan extends StatelessWidget {
  const Tujuan({super.key});

  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    final args =
        ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Scaffold(
      backgroundColor: const Color(0xFFF94A29),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),

                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F8FB),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          args.cover,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) {
                            return const SizedBox(
                              height: 200,
                              child: Center(
                                child: Icon(
                                  Icons.image_not_supported,
                                  size: 50,
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 15),

                      Text(
                        args.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 47, 72),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        args.shortDesc,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          color: Color.fromARGB(255, 0, 47, 72),
                        ),
                      ),

                      const SizedBox(height: 15),

                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Deskripsi Game',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 47, 72),
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        args.description,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 0, 47, 72),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF0081C9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back_ios_outlined,
                          size: 15,
                          color: Color(0xFFF4F8FB),
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Kembali ke game',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFFF4F8FB),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}