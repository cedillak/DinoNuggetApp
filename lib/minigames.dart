import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'minigames/pages/minigamesPage1.dart';
import 'minigames/pages/minigamesPage2.dart';

class MinigamesPage extends StatelessWidget {
  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mini Games'),
      ),
      backgroundColor: Colors.green[200],
      body: PageView(
        controller: _controller,
        children: [
          minigamesPage1(),
          minigamesPage2(),
        ],
      ),
    );
  }
}
