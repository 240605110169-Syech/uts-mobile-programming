import 'package:flutter/material.dart';

class TujuanPage extends StatelessWidget {
  const TujuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text(
          'Informasi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.info_rounded,
                size: 100,
                color: Colors.indigo,
              ),

              const SizedBox(height: 25),

              const Text(
                'Halaman Tujuan',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Text(
                'Ini adalah halaman tujuan dari aplikasi. '
                'Halaman ini dapat dibuka menggunakan Named Route.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade700,
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,

                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },

                  icon: const Icon(Icons.arrow_back),

                  label: const Text(
                    'Kembali ke Halaman Utama',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}