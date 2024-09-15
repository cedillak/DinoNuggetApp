import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage4 extends StatelessWidget {
  const IntroPage4({Key? key}) : super(key: key);

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
                'assets/images/dino_sleepy.png',
                height: 200,
                width: 200,
              ),
              SizedBox(height: 20),
              // Bold text
              Text(
                textAlign: TextAlign.center,
                'As his caretaker,',
                style: GoogleFonts.varelaRound(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              SizedBox(height: 10),
              // Normal text
              Text(
                'your job is to keep Dino Nugget happy and healthy. Feed him, play games, and watch him grow.',
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
