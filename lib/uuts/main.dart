import 'package:flutter/material.dart';

void main() {
  runApp(const MiniMovieApp());
}

class MiniMovieApp extends StatelessWidget {
  const MiniMovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Movie',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF10131C),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFB547),
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF10131C),
          foregroundColor: Colors.white,
          centerTitle: false,
        ),
      ),
      home: const MainNavigationPage(),
    );
  }
}

class Movie {
  final int id;
  final String title;
  final String genre;
  final int year;
  final String rating;
  final String synopsis;
  final IconData icon;
  final List<Color> colors;

  const Movie({
    required this.id,
    required this.title,
    required this.genre,
    required this.year,
    required this.rating,
    required this.synopsis,
    required this.icon,
    required this.colors,
  });
}

const List<Movie> movies = [
  Movie(
    id: 1,
    title: 'Interstellar',
    genre: 'Sci-Fi',
    year: 2014,
    rating: '8.7',
    synopsis:
        'Ketika bumi menghadapi krisis lingkungan, sekelompok penjelajah '
        'melakukan perjalanan melintasi ruang angkasa untuk mencari rumah '
        'baru bagi umat manusia. Mereka harus menghadapi waktu, jarak, dan '
        'pilihan sulit demi masa depan generasi berikutnya.',
    icon: Icons.rocket_launch,
    colors: [Color(0xFF283E75), Color(0xFF111827)],
  ),
  Movie(
    id: 2,
    title: 'The Batman',
    genre: 'Action',
    year: 2022,
    rating: '7.8',
    synopsis:
        'Seorang detektif bertopeng menyelidiki rangkaian kejahatan misterius '
        'di kota Gotham. Penyelidikan tersebut membawanya menghadapi rahasia '
        'kelam kota dan menguji batas antara keadilan dan pembalasan.',
    icon: Icons.nightlight_round,
    colors: [Color(0xFF762D36), Color(0xFF171717)],
  ),
  Movie(
    id: 3,
    title: 'Coco',
    genre: 'Animation',
    year: 2017,
    rating: '8.4',
    synopsis:
        'Miguel, seorang anak yang mencintai musik, secara ajaib memasuki '
        'dunia para leluhurnya. Dalam petualangannya, ia menemukan arti '
        'keluarga, kenangan, dan keberanian untuk mengejar impian.',
    icon: Icons.music_note,
    colors: [Color(0xFFDE762E), Color(0xFF6B2E59)],
  ),
  Movie(
    id: 4,
    title: 'The Notebook',
    genre: 'Romance',
    year: 2004,
    rating: '7.8',
    synopsis:
        'Dua orang dari latar belakang berbeda menjalin hubungan yang penuh '
        'perjuangan. Kisah mereka memperlihatkan bagaimana cinta, kenangan, '
        'dan kesetiaan dapat bertahan menghadapi perubahan kehidupan.',
    icon: Icons.favorite,
    colors: [Color(0xFFB95C72), Color(0xFF462A4B)],
  ),
  Movie(
    id: 5,
    title: 'Joker',
    genre: 'Drama',
    year: 2019,
    rating: '8.4',
    synopsis:
        'Arthur Fleck berusaha menemukan tempatnya di tengah masyarakat '
        'yang keras. Berbagai pengalaman dan perlakuan yang diterimanya '
        'membentuk perubahan besar dalam cara ia memandang dunia.',
    icon: Icons.masks,
    colors: [Color(0xFF547A64), Color(0xFF202D2A)],
  ),
  Movie(
    id: 6,
    title: 'Avengers',
    genre: 'Action',
    year: 2012,
    rating: '8.0',
    synopsis:
        'Sekelompok pahlawan dengan kemampuan berbeda harus bekerja sama '
        'untuk menghadapi ancaman besar. Mereka belajar bahwa kerja sama '
        'dan kepercayaan menjadi kunci untuk melindungi dunia.',
    icon: Icons.shield,
    colors: [Color(0xFF3976B9), Color(0xFF182A49)],
  ),
  Movie(
    id: 7,
    title: 'Finding Nemo',
    genre: 'Animation',
    year: 2003,
    rating: '8.2',
    synopsis:
        'Seekor ikan badut melakukan perjalanan jauh untuk menemukan anaknya '
        'yang hilang. Dalam perjalanan, ia bertemu teman-teman baru dan '
        'belajar menghadapi rasa takut serta mempercayai orang lain.',
    icon: Icons.water,
    colors: [Color(0xFF32A9C7), Color(0xFF174B80)],
  ),
  Movie(
    id: 8,
    title: 'La La Land',
    genre: 'Musical',
    year: 2016,
    rating: '8.0',
    synopsis:
        'Seorang musisi jazz dan seorang aktris muda mengejar impian mereka '
        'di Los Angeles. Hubungan mereka berkembang seiring perjuangan '
        'untuk menyeimbangkan cinta, karier, dan cita-cita.',
    icon: Icons.theater_comedy,
    colors: [Color(0xFF7558B8), Color(0xFFDC6B91)],
  ),
];

const List<String> genres = [
  'Semua',
  'Action',
  'Animation',
  'Drama',
  'Musical',
  'Romance',
  'Sci-Fi',
];

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;
  final Set<int> _favoriteIds = <int>{};

  void _toggleFavorite(Movie movie) {
    setState(() {
      if (_favoriteIds.contains(movie.id)) {
        _favoriteIds.remove(movie.id);
      } else {
        _favoriteIds.add(movie.id);
      }
    });
  }

  void _openDetail(Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => MovieDetailPage(
          movie: movie,
          isFavorite: _favoriteIds.contains(movie.id),
          onFavoritePressed: () => _toggleFavorite(movie),
        ),
      ),
    ).then((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(
        onMovieTap: _openDetail,
        favoriteIds: _favoriteIds,
        onFavoriteTap: _toggleFavorite,
        onExploreGenres: () => setState(() => _selectedIndex = 1),
      ),
      GenrePage(
        onMovieTap: _openDetail,
        favoriteIds: _favoriteIds,
        onFavoriteTap: _toggleFavorite,
      ),
      FavoritesPage(
        favoriteMovies:
            movies.where((movie) => _favoriteIds.contains(movie.id)).toList(),
        onMovieTap: _openDetail,
        favoriteIds: _favoriteIds,
        onFavoriteTap: _toggleFavorite,
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        backgroundColor: const Color(0xFF191D29),
        indicatorColor: const Color(0xFFFFB547).withOpacity(0.2),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.category_outlined),
            selectedIcon: Icon(Icons.category),
            label: 'Genre',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favorit',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final ValueChanged<Movie> onMovieTap;
  final Set<int> favoriteIds;
  final ValueChanged<Movie> onFavoriteTap;
  final VoidCallback onExploreGenres;

  const HomePage({
    super.key,
    required this.onMovieTap,
    required this.favoriteIds,
    required this.onFavoriteTap,
    required this.onExploreGenres,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MINI MOVIE',
                          style: TextStyle(
                            color: Color(0xFFFFB547),
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Temukan film favoritmu',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF252B3A),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.movie_creation_outlined,
                      color: Color(0xFFFFB547),
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            sliver: SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF54427B), Color(0xFF252C49)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Waktunya menonton!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Jelajahi koleksi film dan temukan cerita baru.',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(
                      Icons.local_movies,
                      size: 54,
                      color: Color(0xFFFFC66D),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Pilihan film',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: onExploreGenres,
                    child: const Text('Lihat genre'),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 230,
                mainAxisSpacing: 16,
                crossAxisSpacing: 14,
                childAspectRatio: 0.62,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final movie = movies[index];
                  return MovieCard(
                    movie: movie,
                    isFavorite: favoriteIds.contains(movie.id),
                    onTap: () => onMovieTap(movie),
                    onFavoriteTap: () => onFavoriteTap(movie),
                  );
                },
                childCount: movies.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GenrePage extends StatefulWidget {
  final ValueChanged<Movie> onMovieTap;
  final Set<int> favoriteIds;
  final ValueChanged<Movie> onFavoriteTap;

  const GenrePage({
    super.key,
    required this.onMovieTap,
    required this.favoriteIds,
    required this.onFavoriteTap,
  });

  @override
  State<GenrePage> createState() => _GenrePageState();
}

class _GenrePageState extends State<GenrePage> {
  String _selectedGenre = 'Semua';

  @override
  Widget build(BuildContext context) {
    final filteredMovies = _selectedGenre == 'Semua'
        ? movies
        : movies.where((movie) => movie.genre == _selectedGenre).toList();

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(20, 24, 20, 8),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Jelajahi Genre',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Pilih kategori untuk menemukan film yang sesuai.',
                style: TextStyle(color: Colors.white60),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
            sliver: SliverToBoxAdapter(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: genres.map((genre) {
                  final selected = _selectedGenre == genre;
                  return ChoiceChip(
                    label: Text(genre),
                    selected: selected,
                    onSelected: (_) {
                      setState(() => _selectedGenre = genre);
                    },
                    selectedColor: const Color(0xFFFFB547),
                    labelStyle: TextStyle(
                      color: selected ? Colors.black : Colors.white,
                      fontWeight:
                          selected ? FontWeight.bold : FontWeight.normal,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          if (filteredMovies.isEmpty)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: Text('Belum ada film dalam genre ini.')),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 230,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 14,
                  childAspectRatio: 0.62,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final movie = filteredMovies[index];
                    return MovieCard(
                      movie: movie,
                      isFavorite: widget.favoriteIds.contains(movie.id),
                      onTap: () => widget.onMovieTap(movie),
                      onFavoriteTap: () => widget.onFavoriteTap(movie),
                    );
                  },
                  childCount: filteredMovies.length,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  final List<Movie> favoriteMovies;
  final ValueChanged<Movie> onMovieTap;
  final Set<int> favoriteIds;
  final ValueChanged<Movie> onFavoriteTap;

  const FavoritesPage({
    super.key,
    required this.favoriteMovies,
    required this.onMovieTap,
    required this.favoriteIds,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(20, 24, 20, 8),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Film Favorit',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            sliver: SliverToBoxAdapter(
              child: Text(
                '${favoriteMovies.length} film tersimpan',
                style: const TextStyle(color: Colors.white60),
              ),
            ),
          ),
          if (favoriteMovies.isEmpty)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(28),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 64,
                        color: Color(0xFFFFB547),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Belum ada film favorit',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Tekan ikon hati pada kartu film untuk menyimpannya.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white60),
                      ),
                    ],
                  ),
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 230,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 14,
                  childAspectRatio: 0.62,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final movie = favoriteMovies[index];
                    return MovieCard(
                      movie: movie,
                      isFavorite: favoriteIds.contains(movie.id),
                      onTap: () => onMovieTap(movie),
                      onFavoriteTap: () => onFavoriteTap(movie),
                    );
                  },
                  childCount: favoriteMovies.length,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final Movie movie;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

  const MovieCard({
    super.key,
    required this.movie,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: const Color(0xFF1B202D),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  MovieArtwork(movie: movie),
                  Positioned(
                    top: 7,
                    right: 7,
                    child: Material(
                      color: Colors.black.withOpacity(0.48),
                      shape: const CircleBorder(),
                      child: IconButton(
                        onPressed: onFavoriteTap,
                        tooltip: isFavorite
                            ? 'Hapus dari favorit'
                            : 'Tambah ke favorit',
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite
                              ? const Color(0xFFFF6B81)
                              : Colors.white,
                          size: 21,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 9,
                    bottom: 9,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.55),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star,
                            size: 14,
                            color: Color(0xFFFFC857),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            movie.rating,
                            style: const TextStyle(
                              fontSize: 12,
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
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      movie.genre,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFFFFB547),
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${movie.year}',
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieArtwork extends StatelessWidget {
  final Movie movie;

  const MovieArtwork({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: movie.colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: -25,
            right: -20,
            child: Icon(
              movie.icon,
              size: 125,
              color: Colors.white.withOpacity(0.08),
            ),
          ),
          Center(
            child: Icon(
              movie.icon,
              size: 62,
              color: Colors.white.withOpacity(0.92),
            ),
          ),
          Positioned(
            left: 12,
            right: 12,
            bottom: 34,
            child: Text(
              movie.title.toUpperCase(),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
                shadows: [
                  Shadow(
                    color: Colors.black54,
                    blurRadius: 8,
                    offset: Offset(1, 2),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MovieDetailPage extends StatefulWidget {
  final Movie movie;
  final bool isFavorite;
  final VoidCallback onFavoritePressed;

  const MovieDetailPage({
    super.key,
    required this.movie,
    required this.isFavorite,
    required this.onFavoritePressed,
  });

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  void _toggleFavorite() {
    widget.onFavoritePressed();
    setState(() => _isFavorite = !_isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Film'),
        actions: [
          IconButton(
            onPressed: _toggleFavorite,
            tooltip: _isFavorite ? 'Hapus favorit' : 'Tambah favorit',
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? const Color(0xFFFF6B81) : Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  width: 230,
                  height: 310,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: MovieArtwork(movie: movie),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                movie.title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _InfoChip(
                    icon: Icons.calendar_today,
                    label: '${movie.year}',
                  ),
                  _InfoChip(
                    icon: Icons.category_outlined,
                    label: movie.genre,
                  ),
                  _InfoChip(
                    icon: Icons.star,
                    label: movie.rating,
                  ),
                ],
              ),
              const SizedBox(height: 26),
              const Text(
                'Sinopsis',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                movie.synopsis,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.8,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _toggleFavorite,
                  icon: Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                  ),
                  label: Text(
                    _isFavorite
                        ? 'Hapus dari Favorit'
                        : 'Tambah ke Favorit',
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFFFFB547),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 15),
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

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: const Color(0xFF252B3A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: const Color(0xFFFFB547)),
          const SizedBox(width: 6),
          Text(label),
        ],
      ),
    );
  }
}
