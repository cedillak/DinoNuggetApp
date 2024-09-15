import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({Key? key}) : super(key: key);

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
                'assets/images/dino_drumstick.png',
                height: 200,
                width: 200,
              ),
              SizedBox(height: 20),
              // Bold text
              Text(
                'Once upon a time,',
                style: GoogleFonts.varelaRound(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              SizedBox(height: 10),
              // Normal text
              Text(
                'while preparing a meal, you discovered a tiny, cheerful dino-shaped nugget hiding among the fries and chicken drumsticks.',
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
