
import 'package:flutter/material.dart';

void main() {
  runApp(const MiniMovieApp());
}

// MODEL DATA FILM
class Movie {
  final String title;
  final String genre;
  final int year;
  final String synopsis;
  final IconData posterIcon;
  final Color posterColor;
  bool isFavorite;

  Movie({
    required this.title,
    required this.genre,
    required this.year,
    required this.synopsis,
    required this.posterIcon,
    required this.posterColor,
    this.isFavorite = false,
  });
}

// APLIKASI UTAMA
class MiniMovieApp extends StatelessWidget {
  const MiniMovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Movie',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF12121F),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1B1B2F),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const HomePage(),
    );
  }
}

// HALAMAN UTAMA
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Data film dibuat langsung di dalam kode (hardcoded).
  final List<Movie> movies = [
    Movie(
      title: 'Interstellar',
      genre: 'Sci-Fi',
      year: 2014,
      synopsis:
          'Sekelompok penjelajah melakukan perjalanan melalui lubang '
          'cacing untuk mencari planet baru yang dapat menjadi tempat '
          'tinggal manusia.',
      posterIcon: Icons.rocket_launch,
      posterColor: Colors.indigo,
    ),
    Movie(
      title: 'Inception',
      genre: 'Action, Sci-Fi',
      year: 2010,
      synopsis:
          'Dom Cobb adalah seorang pencuri yang memasuki mimpi orang '
          'lain untuk mengambil informasi. Ia mendapat misi untuk '
          'menanamkan sebuah ide ke dalam pikiran seseorang.',
      posterIcon: Icons.psychology,
      posterColor: Colors.deepPurple,
    ),
    Movie(
      title: 'Avengers: Endgame',
      genre: 'Action, Adventure',
      year: 2019,
      synopsis:
          'Para Avengers yang tersisa berusaha memulihkan alam semesta '
          'setelah kehancuran besar akibat tindakan Thanos.',
      posterIcon: Icons.shield,
      posterColor: Colors.red,
    ),
    Movie(
      title: 'The Lion King',
      genre: 'Animation, Adventure',
      year: 2019,
      synopsis:
          'Simba menjalani perjalanan untuk menerima takdirnya sebagai '
          'raja setelah menghadapi kehilangan dan berbagai tantangan.',
      posterIcon: Icons.pets,
      posterColor: Colors.orange,
    ),
    Movie(
      title: 'Coco',
      genre: 'Animation, Family',
      year: 2017,
      synopsis:
          'Miguel memasuki dunia arwah saat mengejar impiannya menjadi '
          'musisi dan berusaha mengungkap rahasia keluarganya.',
      posterIcon: Icons.music_note,
      posterColor: Colors.teal,
    ),
    Movie(
      title: 'Joker',
      genre: 'Drama, Thriller',
      year: 2019,
      synopsis:
          'Arthur Fleck, seorang pria yang menghadapi tekanan hidup '
          'dan penolakan sosial, mengalami perubahan yang mengarah '
          'pada lahirnya sosok Joker.',
      posterIcon: Icons.masks,
      posterColor: Colors.deepOrange,
    ),
    Movie(
      title: 'Spider-Man',
      genre: 'Action, Adventure',
      year: 2021,
      synopsis:
          'Peter Parker menghadapi konsekuensi ketika identitasnya '
          'sebagai Spider-Man diketahui publik dan berusaha melindungi '
          'orang-orang yang dicintainya.',
      posterIcon: Icons.bolt,
      posterColor: Colors.blue,
    ),
    Movie(
      title: 'Finding Nemo',
      genre: 'Animation, Adventure',
      year: 2003,
      synopsis:
          'Seekor ikan badut bernama Marlin melakukan perjalanan '
          'melintasi lautan untuk menemukan anaknya, Nemo.',
      posterIcon: Icons.water,
      posterColor: Colors.cyan,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mini Movie',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: const Icon(Icons.movie_creation),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '${movies.where((movie) => movie.isFavorite).length} '
                'Favorit',
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 4),
              child: Text(
                'Temukan Film Favoritmu',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                'Referensi film dan sinopsis untukmu.',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
                itemCount: movies.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.67,
                ),
                itemBuilder: (context, index) {
                  final movie = movies[index];

                  return Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 4,
                    color: const Color(0xFF222238),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: InkWell(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                              movie: movie,
                              onFavoriteChanged: (value) {
                                setState(() {
                                  movie.isFavorite = value;
                                });
                              },
                            ),
                          ),
                        );

                        // Perbarui tampilan halaman utama.
                        if (mounted) {
                          setState(() {});
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Container(
                              color: movie.posterColor.withOpacity(0.22),
                              child: Stack(
                                children: [
                                  Center(
                                    child: Icon(
                                      movie.posterIcon,
                                      size: 76,
                                      color: movie.posterColor,
                                    ),
                                  ),
                                  if (movie.isFavorite)
                                    const Positioned(
                                      top: 8,
                                      right: 8,
                                      child: Icon(
                                        Icons.favorite,
                                        color: Colors.pinkAccent,
                                        size: 23,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  movie.genre,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_today,
                                      size: 13,
                                      color: Colors.white60,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      '${movie.year}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white60,
                                      ),
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 13,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// HALAMAN DETAIL FILM
class DetailPage extends StatefulWidget {
  final Movie movie;
  final ValueChanged<bool> onFavoriteChanged;

  const DetailPage({
    super.key,
    required this.movie,
    required this.onFavoriteChanged,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.movie.isFavorite;
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });

    // Sinkronkan status favorit dengan halaman utama.
    widget.onFavoriteChanged(isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Film'),
        actions: [
          IconButton(
            tooltip: isFavorite
                ? 'Hapus dari favorit'
                : 'Tambahkan ke favorit',
            onPressed: toggleFavorite,
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.pinkAccent : Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 260,
                decoration: BoxDecoration(
                  color: movie.posterColor.withOpacity(0.22),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  movie.posterIcon,
                  size: 120,
                  color: movie.posterColor,
                ),
              ),
              const SizedBox(height: 22),
              Text(
                movie.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 8,
                children: [
                  Chip(
                    avatar: const Icon(Icons.category, size: 18),
                    label: Text(movie.genre),
                  ),
                  Chip(
                    avatar: const Icon(Icons.calendar_today, size: 16),
                    label: Text('${movie.year}'),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Card(
                color: const Color(0xFF222238),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite
                            ? Colors.pinkAccent
                            : Colors.white70,
                        size: 26,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          isFavorite ? 'Favorit' : 'Bukan Favorit',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      FilledButton(
                        onPressed: toggleFavorite,
                        child: Text(
                          isFavorite ? 'Hapus' : 'Favoritkan',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Sinopsis',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                movie.synopsis,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.7,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 28),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Kembali ke Daftar Film'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
