import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'screen_arguments.dart';
import 'tujuan.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var title;
  var thumbnail;
  var shortDescription;
  var description;
  var genre;
  var platform;
  var release;
  var cover;
  var gameId;
  var publisher;

  Future<void> getGame(String id) async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://www.freetogame.com/api/game?id=$id',
        ),
      );

      if (response.statusCode == 200) {
        final results = jsonDecode(response.body);

        setState(() {
          gameId = id;
          title = results['title'];
          thumbnail = results['thumbnail'];
          shortDescription = results['short_description'];
          description = results['description'];
          genre = results['genre'];
          platform = results['platform'];
          publisher = results['publisher'];
          release = results['release_date'];

          if (results['screenshots'] != null &&
              results['screenshots'].isNotEmpty) {
            cover = results['screenshots'][0]['image'];
          } else {
            cover = thumbnail;
          }
        });
      } else {
        setState(() {
          gameId = null;
        });
      }
    } catch (e) {
      setState(() {
        gameId = null;
      });

      debugPrint('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();

    // Game default sesuai contoh Modul 08
    getGame('475');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0081C9),
      body: SafeArea(
        child: Center(
          child: gameId == null
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Tujuan.routeName,
                            arguments: ScreenArguments(
                              cover,
                              title,
                              description,
                              shortDescription,
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  thumbnail,
                                  height: 200,
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
                                title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 10),

                              Text(
                                shortDescription,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),

                              const SizedBox(height: 15),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Genre: $genre'),
                                      const SizedBox(height: 5),
                                      Text('Platform: $platform'),
                                    ],
                                  ),

                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Publisher: $publisher'),
                                      const SizedBox(height: 5),
                                      Text('Release: $release'),
                                    ],
                                  ),
                                ],
                              ),

                              const SizedBox(height: 15),

                              const Text(
                                'Klik untuk melihat detail game',
                                style: TextStyle(
                                  color: Color(0xFF0081C9),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}