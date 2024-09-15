import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image in the middle
              Image.asset(
                'assets/images/dino_heart.png',
                height: 200,
                width: 200,
              ),
              SizedBox(height: 20),
              // Bold text
              Text(
                textAlign: TextAlign.center,
                'Dino Nugget captured your heart.',
                style: GoogleFonts.varelaRound(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              SizedBox(height: 10),
              // Normal text
              Text(
                'You decided to adopt him and give him a new home.',
                style: GoogleFonts.varelaRound(
                  fontSize: 20,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
