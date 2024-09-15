import 'package:flutter/material.dart';
import 'minigames/pages/minigamesPage1.dart';
import 'minigames/pages/minigamesPage2.dart';

class MiniGamesPage extends StatefulWidget {
  const MiniGamesPage({super.key});

  @override
  State<MiniGamesPage> createState() => _MiniGamesPageState();
}

class _MiniGamesPageState extends State<MiniGamesPage> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Games'),
      ),
      backgroundColor: Colors.green[200],
      body: PageView(
        controller: _controller,
        children: const [
          MinigamesPage1(),
          MinigamesPage2(),
        ],
      ),
    );
  }
}
