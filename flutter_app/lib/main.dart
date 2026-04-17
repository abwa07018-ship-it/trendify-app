import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/auth_provider.dart';
import 'services/style_filter_provider.dart';
import 'screens/auth/login_screen.dart';
import 'screens/feed/feed_screen.dart';
import 'screens/upload/record_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'models/video_model.dart';
import 'utils/trendify_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => StyleFilterProvider()),
      ],
      child: const TrendifyApp(),
    ),
  );
}

class TrendifyApp extends StatelessWidget {
  const TrendifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: TrendifyBrand.appName,
      debugShowCheckedModeBanner: false,
      theme: TrendifyBrand.theme,
      home: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          if (!auth.isAuthenticated) return const LoginScreen();
          return const MainShell();
        },
      ),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  static const _sampleVideoUrls = [
    'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
    'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
    'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
  ];

  // Mock feed data for the beta demo
  final List<VideoModel> _mockVideos = List.generate(
    15,
    (i) => VideoModel(
      id: 'vid_$i',
      userId: 'user_$i',
      username: [
        'sara_art', 'mo_creates', 'lina.fx', 'ali_style',
        'nora_trend', 'zaid_film', 'huda.ai', 'omar_vfx',
        'dina_edits', 'rami_cam', 'layla.go', 'khaled_v',
        'mona_ai', 'yusuf_fx', 'rana.art'
      ][i],
      videoUrl: _sampleVideoUrls[i % _sampleVideoUrls.length],
      caption: i % 3 == 0
          ? 'Check out my Trendify filter! \uD83D\uDD25\u2728'
          : i % 3 == 1
              ? 'This AI style is insane \uD83C\uDFA8 #trendify'
              : 'Just vibing today #fyp #fun',
      tags: i % 3 == 0
          ? ['trendify', 'anime', 'trend']
          : i % 3 == 1
              ? ['sketch', 'art', 'trendify']
              : ['fyp', 'fun', 'daily'],
      styleFilter: StyleFilterMeta(
        applied: i % 3 != 2,
        styleName: i % 3 != 2
            ? ['anime', 'sketch', 'oil_painting', 'watercolor', 'pop_art'][i % 5]
            : 'none',
        modelVersion: i % 3 != 2 ? '1.0' : '',
      ),
      hasTrendBadge: i % 3 != 2,
      stats: VideoStats(
        views: (i + 1) * 2430,
        likes: (i + 1) * 891,
        shares: (i + 1) * 134,
        comments: (i + 1) * 67,
      ),
      createdAt: DateTime.now().subtract(Duration(hours: i * 3)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          FeedScreen(videos: _mockVideos),
          const Center(
              child: Text('Discover',
                  style: TextStyle(color: Colors.white, fontSize: 18))),
          const SizedBox(), // Record opens as full screen overlay
          const Center(
              child: Text('Inbox',
                  style: TextStyle(color: Colors.white, fontSize: 18))),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index == 2) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => const RecordScreen(),
              ));
              return;
            }
            setState(() => _currentIndex = index);
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          items: [
            const BottomNavigationBarItem(
                icon: Icon(Icons.home_filled), label: 'Home'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.search), label: 'Discover'),
            BottomNavigationBarItem(
              icon: Container(
                width: 44,
                height: 30,
                decoration: BoxDecoration(
                  gradient: TrendifyBrand.logoGradient,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 22),
              ),
              label: '',
            ),
            const BottomNavigationBarItem(
                icon: Icon(Icons.message_outlined), label: 'Inbox'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
