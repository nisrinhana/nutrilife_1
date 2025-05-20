import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/onboarding_page.dart';
import 'pages/home_page.dart';
import 'pages/explore_page.dart';
import 'pages/achievements_page.dart';
import 'pages/profile_page.dart';
import 'pages/history_page.dart';
import 'pages/meal_plan_page.dart';
import 'pages/recommendation_page.dart';
import 'pages/reminder_page.dart';
import 'pages/workout_page.dart';
import 'pages/timer_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nutrilife',
      theme: ThemeData(
        primaryColor: const Color(0xFF800000),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/onboarding',
      routes: {
        '/onboarding': (context) => const OnboardingPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const MainPage(),
        '/history': (context) => const HistoryPage(),
        '/meal_plan': (context) => const MealPlanPage(),
        '/recommendation': (context) => const RecommendationPage(),
        '/reminder': (context) => const ReminderPage(),
        '/workout': (context) => const WorkoutPage(),
        '/timer': (context) => const TimerPage(),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  int _userId = 0; // Default userId, akan diupdate setelah login

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null && args['userId'] != null) {
      _userId = args['userId'];
    }
  }

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      const HomePage(),
      const ExplorePage(),
      const AchievementsPage(),
      ProfilePage(userId: _userId), // Kirim userId ke ProfilePage
    ]);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Eksplorasi'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Pencapaian'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF800000),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}