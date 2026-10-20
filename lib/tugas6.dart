import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daftar Game',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(
        title: 'Daftar Game',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Menyimpan data game dari API
  List dataGame = [];

  @override
  void initState() {
    super.initState();
    _ambilData();
  }

  // Method untuk mengambil data dari API FreeToGame
  Future<void> _ambilData() async {
    try {
      final response = await http.get(
        Uri.parse('https://www.freetogame.com/api/games'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          // Mengambil 20 data pertama
          dataGame = data.take(20).toList();
        });
      } else {
        throw Exception(
          'Gagal load data dari FreeToGame API',
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: dataGame.length,
        itemBuilder: (context, index) {
          return _listItem(
            dataGame[index]['thumbnail'] ??
                'https://via.placeholder.com/150',
            dataGame[index]['title'] ??
                'Tidak ada judul',
            dataGame[index]['genre'] ??
                'Tidak ada genre',
            dataGame[index]['release_date'] ??
                'Tidak ada tanggal',
          );
        },
      ),
    );
  }
}


// Fungsi tombol Baca Info
Container _tombolBaca() {
  return Container(
    padding: const EdgeInsets.symmetric(
      vertical: 5,
      horizontal: 15,
    ),
    decoration: BoxDecoration(
      color: Colors.orange,
      borderRadius: BorderRadius.circular(15),
    ),
    child: const Text(
      'Baca Info',
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  );
}


// Fungsi untuk membuat item game
Container _listItem(
  String url,
  String judul,
  String genre,
  String rilis,
) {
  return Container(
    padding: const EdgeInsets.all(15),
    margin: const EdgeInsets.only(
      bottom: 10,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          blurRadius: 5,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        // Thumbnail game
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network(
            url,
            width: 100,
            height: 70,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 100,
                height: 70,
                color: Colors.grey[300],
                child: const Icon(
                  Icons.image_not_supported,
                ),
              );
            },
          ),
        ),

        const SizedBox(width: 10),

        // Informasi game
        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                judul,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                genre,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 2),

              Text(
                rilis,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 8),

              _tombolBaca(),
            ],
          ),
        ),
      ],
    ),
  );
}