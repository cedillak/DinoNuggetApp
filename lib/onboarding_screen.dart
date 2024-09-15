import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'IntroPages/IntroPage1.dart';
import 'IntroPages/IntroPage2.dart';
import 'IntroPages/IntroPage3.dart';
import 'IntroPages/IntroPage4.dart';
//import 'home_page.dart';
import 'IntroPages/NewPet.dart';
import 'package:lottie/lottie.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController _controller = PageController();
  int currentPageIndex = 0;

  void _navigateToNewPetPage() {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500),
        pageBuilder: (_, __, ___) => NewPet(),
        transitionsBuilder: (_, animation, __, child) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn),
            ),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 253, 208, 1.0),
      body: Stack(
        children: [
          // Background animation
          Positioned.fill(
            child: Lottie.asset(
              'assets/Lottie/Animation - greenish clouds.json',
              fit: BoxFit.cover,
            ),
          ),
          // Page content
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 500,
                child: PageView(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      currentPageIndex = index;
                    });
                  },
                  children: const [
                    IntroPage1(),
                    IntroPage2(),
                    IntroPage3(),
                    IntroPage4(),
                  ],
                ),
              ),
              // Conditional button based on currentPageIndex
              if (currentPageIndex == 3)
                ElevatedButton(
                  onPressed: _navigateToNewPetPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: Text(
                    "Let's go!", // Customize text as needed
                    style: GoogleFonts.pangolin(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                )
              else
                ElevatedButton(
                  onPressed: () {
                    _controller.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: Text(
                    currentPageIndex == 0 ? 'Start' : 'Next',
                    style: GoogleFonts.pangolin(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              // Page indicator
              SmoothPageIndicator(
                controller: _controller,
                count: 4,
                effect: JumpingDotEffect(
                  activeDotColor: Colors.green,
                  dotColor: Colors.green.shade100,
                  dotHeight: 30,
                  dotWidth: 30,
                  spacing: 16,
                  jumpScale: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
