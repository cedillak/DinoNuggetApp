import 'package:flutter/material.dart';
import 'onboarding_screen.dart';
import 'newgame.dart';
import 'homepage.dart';
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
        '/': (context) => SplashScreen(),
        '/OnBoardingScreen': (context) => OnBoardingScreen(),
        '/newgame': (context) => NewPet(),
        '/homepage': (context) => HomePage(
              petName: 'Dino',
              birthDate: DateTime.now(),
            ),
        '/closet': (context) => ClosetPage(),
        '/minigames': (context) => MinigamesPage(),
        '/history': (context) => HistoryPage(
              birthDate: DateTime.now(),
            ),
      },
    );
  }
}
