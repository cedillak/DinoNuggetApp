import 'package:flutter/material.dart';
import 'IntroPages/NewPet.dart';
import 'onboarding_screen.dart';
import 'home_page.dart';
import 'closet.dart';
import 'minigames.dart';
import 'history.dart';
import 'splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DinoNugget',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        //'/': (context) => ClosetPage(),
        //'/': (context) => HistoryPage(birthDate: DateTime.now(),),
        //'/': (context) => MiniGamesPage(),
        '/OnBoardingScreen': (context) => const OnBoardingScreen(),
        '/newgame': (context) => const NewPet(),
        '/homepage': (context) => HomePage(
              petName: 'Dino',
              birthDate: DateTime.now(),
            ),
        '/closet': (context) => ClosetPage(),
        '/minigames': (context) =>
            MiniGamesPage(), // Ensure this matches the class name
        '/history': (context) => HistoryPage(
              birthDate: DateTime.now(),
            ),
      },
    );
  }
}
