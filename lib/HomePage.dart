import 'package:flutter/material.dart';
import 'dart:async';
import 'history.dart';
import 'newgame.dart'; // Import new game page
import 'closet.dart'; // Import closet page

class HomePage extends StatefulWidget {
  final String petName;
  final DateTime birthDate;

  const HomePage({required this.petName, required this.birthDate, Key? key})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _hunger = 100;
  double _health = 100;
  Timer? _hungerTimer;
  Timer? _healthTimer;
  String _currentImage = 'assets/images/pet.png';

  @override
  void initState() {
    super.initState();
    _startHungerTimer();
  }

  void _startHungerTimer() {
    _hungerTimer = Timer.periodic(Duration(seconds: 60), (timer) {
      setState(() {
        _hunger -= 1;
        if (_hunger <= 0) {
          _hunger = 0;
          _startHealthTimer(); // Start health timer when hunger is 0
        } else {
          _healthTimer?.cancel(); // Cancel health timer if hunger is not 0
        }
      });
    });
  }

  void _startHealthTimer() {
    _healthTimer ??= Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_hunger == 0) {
          _health -= 1;
          if (_health <= 0) {
            _health = 0;
            _healthTimer?.cancel();
            _showDeathDialog();
          }
        }
      });
    });
  }

  void _showDeathDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Dino Died'),
          content: Text('${widget.petName} died from hunger.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _restartGame(); // Call function to restart the game
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _restartGame() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => NewPet()),
    );
  }

  @override
  void dispose() {
    _hungerTimer?.cancel();
    _healthTimer?.cancel();
    super.dispose();
  }

  Future<void> _openCloset() async {
    final selectedImage = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ClosetPage()),
    );
    if (selectedImage != null) {
      setState(() {
        _currentImage = selectedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: Colors.green[400],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.transparent, // Changed name box color
                    borderRadius: BorderRadius.circular(8), // Rounded edges
                  ),
                  child: Text(
                    widget.petName,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Text('Hunger: ${_hunger.toStringAsFixed(0)}%'),
                    LinearProgressIndicator(
                      value: _hunger / 100,
                      minHeight:
                          10, // Adjusted thickness for hunger progress bar
                    ),
                    SizedBox(height: 20),
                    Text('Health: ${_health.toStringAsFixed(0)}%'),
                    LinearProgressIndicator(
                      value: _health / 100,
                      minHeight:
                          10, // Adjusted thickness for health progress bar
                    ),
                  ],
                ),
                SizedBox(height: 100),
                Image.asset(
                  _currentImage,
                  width: 300, // Resize pet image width
                  height: 300, // Resize pet image height
                ),
                SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _openCloset,
                      child: Text('Closet'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/minigames');
                      },
                      child: Text('Mini Games'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HistoryPage(birthDate: widget.birthDate),
                          ),
                        );
                      },
                      child: Text('History'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
