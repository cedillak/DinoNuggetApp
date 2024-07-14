import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';

import 'onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  get splash => null;

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Center(
            child:
                LottieBuilder.asset('assets/Lottie/Animation - Loading.json'),
          )
        ],
      ),
      nextScreen: const OnBoardingScreen(),
      splashIconSize: 400,
      backgroundColor: Colors.green,
    );
  }
}
