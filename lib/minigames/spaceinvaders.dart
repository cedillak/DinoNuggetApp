import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class SpaceInvaders extends StatefulWidget {
  @override
  _SpaceInvadersState createState() => _SpaceInvadersState();
}

class _SpaceInvadersState extends State<SpaceInvaders> {
  static int spaceShipCenter = 670;
  static int numberOfSquares = 700;
  static bool alienGotHit = false;
  static bool playerGotHit = false;
  var myGoogleFont = GoogleFonts.orbitron(
      textStyle: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30));

  static List<int> spaceship = [
    spaceShipCenter - 21,
    spaceShipCenter - 20,
    spaceShipCenter - 19,
    spaceShipCenter - 18,
    spaceShipCenter - 1,
    spaceShipCenter,
    spaceShipCenter + 1,
    spaceShipCenter + 2
  ];

  List<int> barriers = [
    numberOfSquares - 160 + 2,
    numberOfSquares - 160 + 3,
    numberOfSquares - 160 + 4,
    numberOfSquares - 160 + 5,
    numberOfSquares - 160 + 8,
    numberOfSquares - 160 + 9,
    numberOfSquares - 160 + 10,
    numberOfSquares - 160 + 11,
    numberOfSquares - 160 + 14,
    numberOfSquares - 160 + 15,
    numberOfSquares - 160 + 16,
    numberOfSquares - 160 + 17,
    numberOfSquares - 140 + 2,
    numberOfSquares - 140 + 3,
    numberOfSquares - 140 + 4,
    numberOfSquares - 140 + 5,
    numberOfSquares - 140 + 8,
    numberOfSquares - 140 + 9,
    numberOfSquares - 140 + 10,
    numberOfSquares - 140 + 11,
    numberOfSquares - 140 + 14,
    numberOfSquares - 140 + 15,
    numberOfSquares - 140 + 16,
    numberOfSquares - 140 + 17,
  ];

  static int alienStartPos = 30;
  List<int> alien = [
    alienStartPos,
    alienStartPos + 1,
    alienStartPos + 2,
    alienStartPos + 3,
    alienStartPos + 4,
    alienStartPos + 5,
    alienStartPos + 6,
    alienStartPos + 20,
    alienStartPos + 1 + 20,
    alienStartPos + 2 + 20,
    alienStartPos + 3 + 20,
    alienStartPos + 4 + 20,
    alienStartPos + 5 + 20,
    alienStartPos + 6 + 20
  ];

  int playerMissileShot = -1;
  int alienMissileShot = -1;
  bool timeForNextShot = false;
  bool alienGunAtBack = true;
  String direction = 'left'; // initial direction

  void startGame() {
    setState(() {
      alienGotHit = false;
      playerGotHit = false;
      playerMissileShot = -1;
      alienMissileShot = -1;
      direction = 'left';
      alien = [
        alienStartPos,
        alienStartPos + 1,
        alienStartPos + 2,
        alienStartPos + 3,
        alienStartPos + 4,
        alienStartPos + 5,
        alienStartPos + 6,
        alienStartPos + 20,
        alienStartPos + 1 + 20,
        alienStartPos + 2 + 20,
        alienStartPos + 3 + 20,
        alienStartPos + 4 + 20,
        alienStartPos + 5 + 20,
        alienStartPos + 6 + 20
      ];
    });

    const duration = Duration(milliseconds: 700);
    Timer.periodic(
      duration,
      (Timer timer) {
        alienMoves();
      },
    );

    const missileDuration = Duration(seconds: 2);
    Timer.periodic(
      missileDuration,
      (Timer timer) {
        alienMissile();
      },
    );
  }

  void alienMoves() {
    setState(() {
      if ((alien[0] - 1) % 20 == 0) {
        direction = 'right';
      } else if ((alien.last + 2) % 20 == 0) {
        direction = 'left';
      }

      if (direction == 'right') {
        for (int i = 0; i < alien.length; i++) {
          alien[i] += 1;
        }
      } else {
        for (int i = 0; i < alien.length; i++) {
          alien[i] -= 1;
        }
      }
    });
  }

  void moveLeft() {
    setState(() {
      for (int i = 0; i < spaceship.length; i++) {
        spaceship[i] -= 1;
      }
    });
  }

  void moveRight() {
    setState(() {
      for (int i = 0; i < spaceship.length; i++) {
        spaceship[i] += 1;
      }
    });
  }

  void updateDamage() {
    setState(() {
      if (alien.contains(playerMissileShot)) {
        alien.remove(playerMissileShot);
        playerMissileShot = -1;
        alienGotHit = true;
      }
      if (spaceship.contains(alienMissileShot)) {
        spaceship.remove(alienMissileShot);
        alienMissileShot = alien.first;
      }
      if (barriers.contains(alienMissileShot)) {
        barriers.remove(alienMissileShot);
        alienMissileShot = alien.first;
      }
      if (playerMissileShot == alienMissileShot) {
        playerMissileShot = -1;
        alienMissileShot = alien.first;
        alienGotHit = true;
      }
      if (barriers.contains(playerMissileShot)) {
        playerMissileShot = -1;
        alienGotHit = true;
      }
    });
  }

  void fireMissile() {
    if (playerMissileShot == -1) {
      playerMissileShot = spaceship.first;
      alienGotHit = false;
      const duration = Duration(milliseconds: 50);
      Timer.periodic(
        duration,
        (Timer timer) {
          setState(() {
            playerMissileShot -= 20;
          });
          updateDamage();
          if (alienGotHit || playerMissileShot < 0) {
            timer.cancel();
            playerMissileShot = -1;
          }
        },
      );
    }
  }

  void updateAlienMissile() {
    setState(() {
      alienMissileShot += 20;
      if (alienMissileShot > numberOfSquares) {
        timeForNextShot = true;
      }
    });
  }

  void alienMissile() {
    if (alienMissileShot == -1 || timeForNextShot) {
      alienMissileShot = alienGunAtBack ? alien.last : alien.first;
      alienGunAtBack = !alienGunAtBack;
      timeForNextShot = false;
      const duration = Duration(milliseconds: 100);
      Timer.periodic(
        duration,
        (Timer timer) {
          setState(() {
            alienMissileShot += 20;
          });
          updateDamage();
          if (alienMissileShot > numberOfSquares || timeForNextShot) {
            timer.cancel();
            alienMissileShot = -1;
          }
        },
      );
    }
  }

  void _showGameOverScreen() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('GAME OVER'),
            content: Text('Your score: '),
            actions: <Widget>[
              TextButton(
                child: Text('Play Again'),
                onPressed: () {
                  Navigator.of(context).pop();
                  startGame();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              child: Container(
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: numberOfSquares,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 20),
                    itemBuilder: (BuildContext context, int index) {
                      if (playerMissileShot == index ||
                          spaceship.first == index) {
                        return Container(
                          padding: EdgeInsets.all(2),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(color: Colors.red)),
                        );
                      } else if (spaceship.contains(index) ||
                          barriers.contains(index)) {
                        return Center(
                          child: Container(
                            padding: EdgeInsets.all(2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }

                      if (alien.contains(index) || alienMissileShot == index) {
                        return Container(
                          padding: EdgeInsets.all(2),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(color: Colors.green)),
                        );
                      } else {
                        return Container(
                          padding: EdgeInsets.all(2),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(color: Colors.grey[900])),
                        );
                      }
                    }),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 5, bottom: 40.0, left: 20.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                      onTap: () {
                        startGame();
                      },
                      child:
                          Container(child: Text('Play', style: myGoogleFont))),
                ),
                GestureDetector(
                    onTap: moveLeft,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.grey[800],
                        child: Icon(
                          Icons.arrow_left,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    )),
                GestureDetector(
                    onTap: () {
                      fireMissile();
                      HapticFeedback.vibrate();
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.grey[800],
                        child: Icon(
                          Icons.arrow_drop_up,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    )),
                GestureDetector(
                    onTap: moveRight,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.grey[800],
                        child: Icon(
                          Icons.arrow_right,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
