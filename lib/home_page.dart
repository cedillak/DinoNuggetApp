import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';
import 'IntroPages/NewPet.dart';
import 'history.dart';
import 'closet.dart';
import 'minigames.dart';

class HomePage extends StatefulWidget {
  final String petName;
  final DateTime birthDate;

  HomePage({required this.petName, required this.birthDate, super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _hunger = 100;
  double _health = 100;
  Timer? _hungerTimer;
  Timer? _healthTimer;
  String _currentImage = 'assets/images/dino_happy.png';

  @override
  void initState() {
    super.initState();
    _startHungerTimer();
    _startHealthTimer();
  }

  void _updateDinoImage() {
    if (_hunger <= 0) {
      _currentImage = 'assets/images/dino_sad.png';
    } else if (_hunger > 70) {
      _currentImage = 'assets/images/dino_happy.png';
    } else if (_hunger > 40 && _hunger <= 70) {
      _currentImage = 'assets/images/dino_worried.png';
    } else if (_hunger > 0 && _hunger <= 40) {
      _currentImage = 'assets/images/dino_angry.png';
    }
  }

  void _startHungerTimer() {
    _hungerTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _hunger -= 5;
        if (_hunger < 0) {
          _hunger = 0;
        }
        _updateDinoImage(); // Update image based on new hunger level
      });
    });
  }

  void _startHealthTimer() {
    _healthTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_hunger == 0) {
          _health -= 5;
          if (_health < 0) {
            _health = 0;
            _healthTimer?.cancel();
            _showDeathDialog();
          }
        } else if (_hunger >= 80) {
          _health += 10;
          if (_health > 100) {
            _health = 100;
          }
        }
        _updateDinoImage(); // Update image based on new health level
      });
    });
  }

  void _showDeathDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Dino Died'),
          content: Text('${widget.petName} died from hunger.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _restartGame();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _restartGame() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const NewPet()),
    );
  }

  void _feedPet() {
    setState(() {
      _hunger += 10;
      if (_hunger > 100) {
        _hunger = 100;
      }
    });
  }

  @override
  void dispose() {
    _hungerTimer?.cancel();
    _healthTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: Stack(
        children: [
          Lottie.asset(
            'assets/Lottie/mountain_bg.json',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        print('Navigating to ClosetPage');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ClosetPage()),
                        );
                      },
                      child: const Text('Closet'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        print('Navigating to MiniGamesPage');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MiniGamesPage()),
                        );
                      },
                      child: const Text('Mini Games'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        print('Navigating to HistoryPage');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HistoryPage(birthDate: widget.birthDate),
                          ),
                        );
                      },
                      child: const Text('History'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          widget.petName,
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                offset: Offset(
                                    2.0, 2.0), // Horizontal and vertical offset
                                color: Colors.black.withOpacity(
                                    0.5), // Shadow color with some transparency
                                blurRadius: 4.0, // Blur radius
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          Text(
                            'Hunger: ${_hunger.toStringAsFixed(0)}%',
                            style: TextStyle(
                              fontSize: 18, // Increased size
                              fontWeight: FontWeight.w500, // Make it bold
                              color: Colors.black,
                              fontFamily: 'Roboto', // Specify the font family
                            ),
                          ),
                          LinearProgressIndicator(
                            value: _hunger / 100,
                            minHeight: 10,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Health: ${_health.toStringAsFixed(0)}%',
                            style: TextStyle(
                              fontSize: 18, // Increased size
                              fontWeight: FontWeight.w500, // Make it bold
                              color: Colors.black,
                              fontFamily: 'Roboto', // Specify the font family
                            ),
                          ),
                          LinearProgressIndicator(
                            value: _health / 100,
                            minHeight: 10,
                          ),
                        ],
                      ),

                      const SizedBox(height: 70),
                      Image.asset(
                        _currentImage,
                        width: 300,
                        height: 300,
                        key: ValueKey(_currentImage),
                      ),
                      const SizedBox(
                          height: 10), // Adjusted space before the button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Feed your dino \n'
                            'a drumstick \n'
                            'to keep him \n'
                            'happy and healthy!\n',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1,
                              shadows: [
                                Shadow(
                                  offset: Offset(2.0,
                                      2.0), // Horizontal and vertical offset
                                  color: Colors.black.withOpacity(
                                      0.5), // Shadow color with some transparency
                                  blurRadius: 4.0, // Blur radius
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          GestureDetector(
                            onTap: _feedPet,
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 70, // Bigger button
                              child: Lottie.asset(
                                'assets/Lottie/Animation - feed_icon.json',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      //const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
