import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Info App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF9F6EE),
        primaryColor: const Color(0xFF132A3E),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF132A3E),
          primary: const Color(0xFF132A3E),
          secondary: const Color(0xFFFF9F1C),
        ),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

// =============================================================================
// 1. MODEL DATA & DUMMY DATA
// =============================================================================
class Game {
  final String id;
  final String title;
  final String category;
  final String releaseDate;
  final String imageUrl;
  final bool isPopular;
  final Map<String, String>? sysReq;
  final String description;

  Game({
    required this.id,
    required this.title,
    required this.category,
    required this.releaseDate,
    required this.imageUrl,
    this.isPopular = false,
    this.sysReq,
    required this.description,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      category: json['category'] ?? '',
      releaseDate: json['release_date'] ?? '',
      imageUrl: json['image_url'] ?? '',
      isPopular: json['is_popular'] ?? false,
      sysReq: json['sys_req'] != null ? Map<String, String>.from(json['sys_req']) : null,
      description: json['description'] ?? '',
    );
  }
}

final List<Game> dummyGames = [
  Game(
    id: '1',
    title: 'Genshin Impact',
    category: 'ARPG',
    releaseDate: '28 September 2020',
    imageUrl: 'https://images.unsplash.com/photo-1542751371-adc38448a05e?q=80&w=600&auto=format&fit=crop',
    isPopular: true,
    sysReq: {
      'OS': 'Windows 7 SP1 64-bit',
      'Processor': 'Intel Core i7 or equivalent',
      'Memory': '16 GB',
      'Graphics': 'NVIDIA GeForce GTX 1060 6GB',
      'Storage': '30 GB',
    },
    description: "If you've been looking for a game to scratch that open-world ARPG itch, Genshin Impact is a great choice.",
  ),
  Game(
    id: '2',
    title: 'Overwatch 2',
    category: 'Shooter',
    releaseDate: '04 Oktober 2022',
    imageUrl: 'https://images.unsplash.com/photo-1538481199705-c710c4e965fc?q=80&w=600&auto=format&fit=crop',
    isPopular: true,
    sysReq: {
      'OS': 'Windows 10 64-bit',
      'Processor': 'Intel Core i3',
      'Memory': '6 GB',
      'Graphics': 'NVIDIA GeForce GTX 600 series',
      'Storage': '50 GB',
    },
    description: 'Overwatch 2 is an always-on and free-to-play team-based action game.',
  ),
  Game(
    id: '3',
    title: 'Diablo Immortal',
    category: 'MMOARPG',
    releaseDate: '02 Juni 2022',
    imageUrl: 'https://images.unsplash.com/photo-1511512578047-dfb367046420?q=80&w=600&auto=format&fit=crop',
    isPopular: true,
    description: 'A groundbreaking massively multiplayer online action-RPG.',
  ),
];

// =============================================================================
// 2. MAIN PAGE (BOTTOM NAVIGATION)
// =============================================================================
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [const HomePage(), const GameListPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFFFF9F1C),
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color(0xFF132A3E),
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.sports_esports), label: 'Daftar Game'),
        ],
      ),
    );
  }
}

// =============================================================================
// 3. HOME PAGE
// =============================================================================
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Game> popularGames = dummyGames.where((g) => g.isPopular).toList();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFF132A3E),
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Selamat Datang', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                    const Text('Info game apa yang kamu butuhkan?', style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Masukkan judul game',
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.12),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                        prefixIcon: const Icon(Icons.search, color: Colors.amber),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('Game Populer', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 130,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: popularGames.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => GameDetailPage(game: popularGames[index]))),
                      child: Container(
                        width: 200,
                        margin: const EdgeInsets.only(left: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(image: NetworkImage(popularGames[index].imageUrl), fit: BoxFit.cover),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('Game Terbaru', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: dummyGames.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) => GameCardTile(game: dummyGames[index]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// 4. GAME LIST PAGE
// =============================================================================
class GameListPage extends StatelessWidget {
  const GameListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar game'), backgroundColor: const Color(0xFF132A3E), foregroundColor: Colors.white),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: dummyGames.length,
        itemBuilder: (context, index) => GameCardTile(game: dummyGames[index]),
      ),
    );
  }
}

class GameCardTile extends StatelessWidget {
  final Game game;
  const GameCardTile({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Image.network(game.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
        title: Text(game.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(game.category),
        trailing: ElevatedButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => GameDetailPage(game: game))),
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF9F1C)),
          child: const Text('Baca Info', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}

// =============================================================================
// 5. GAME DETAIL PAGE
// =============================================================================
class GameDetailPage extends StatelessWidget {
  final Game game;
  const GameDetailPage({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.network(game.imageUrl, height: 200, width: double.infinity, fit: BoxFit.cover),
                  IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(game.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    if (game.sysReq != null) ...[
                      const Text('Minimum System Requirements', style: TextStyle(fontWeight: FontWeight.bold)),
                      ...game.sysReq!.entries.map((e) => Text('${e.key}: ${e.value}')),
                      const SizedBox(height: 10),
                    ],
                    Text(game.description),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}