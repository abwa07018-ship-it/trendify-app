import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/auth_provider.dart';
import 'services/style_filter_provider.dart';
import 'screens/auth/login_screen.dart';
import 'screens/feed/feed_screen.dart';
import 'screens/upload/record_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/discover/discover_screen.dart';
import 'screens/inbox/inbox_screen.dart';
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

  final List<VideoModel> _mockVideos = List.generate(5, (i) => VideoModel(
    id: 'vid_',
    userId: 'u_',
    username: 'user_',
    videoUrl: [
      'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
      'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
      'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
    ][i % 3],
    caption: 'Real video test 🔥',
    tags: ['trendify', 'beta'],
    styleFilter: StyleFilterMeta(applied: true, styleName: 'anime'),
    hasTrendBadge: true,
    stats: VideoStats(views: 1200, likes: 450, shares: 32, comments: 12),
    createdAt: DateTime.now(),
  ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          FeedScreen(videos: _mockVideos),
          const DiscoverScreen(),
          const SizedBox(),
          const InboxScreen(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const RecordScreen()));
            return;
          }
          setState(() => _currentIndex = index);
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          const BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Discover'),
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
          const BottomNavigationBarItem(icon: Icon(Icons.message_outlined), label: 'Inbox'),
          const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
