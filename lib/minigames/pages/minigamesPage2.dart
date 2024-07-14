import 'package:flutter/material.dart';

class minigamesPage2 extends StatelessWidget {
  const minigamesPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: Colors.brown[400],
            child: Center(child: Text(' MINI GAMES PAGE 2')),
          ),
        ),
      ),
    );
  }
}
