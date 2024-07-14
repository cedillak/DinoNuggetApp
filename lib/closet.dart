import 'package:flutter/material.dart';

class ClosetPage extends StatefulWidget {
  @override
  _ClosetPageState createState() => _ClosetPageState();
}

class _ClosetPageState extends State<ClosetPage> {
  String _currentColor = 'default';
  String _currentAccessory = 'none';
  String _currentImage = 'assets/images/pet.png';

  void _updateImage() {
    String baseImage;
    switch (_currentColor) {
      case 'green':
        baseImage = 'assets/images/pet_green.png';
        break;
      case 'blue':
        baseImage = 'assets/images/pet_blue.png';
        break;
      default:
        baseImage = 'assets/images/pet.png';
    }

    String accessoryImage;
    switch (_currentAccessory) {
      case 'hat':
        accessoryImage = _currentColor == 'default'
            ? 'assets/images/dino_hat.png'
            : _currentColor == 'green'
                ? 'assets/images/dino_green_hat.png'
                : 'assets/images/dino_blue_hat.png';
        break;
      case 'glasses':
        accessoryImage = _currentColor == 'default'
            ? 'assets/images/dino_glasses.png'
            : _currentColor == 'green'
                ? 'assets/images/dino_green_glasses.png'
                : 'assets/images/dino_blue_glasses.png';
        break;
      default:
        accessoryImage = baseImage;
    }

    setState(() {
      _currentImage = accessoryImage;
    });
  }

  void _setColor(String color) {
    setState(() {
      _currentColor = color;
      _updateImage();
    });
  }

  void _setAccessory(String accessory) {
    setState(() {
      _currentAccessory = accessory;
      _updateImage();
    });
  }

  void _saveSelection() {
    // Save the current image selection to use in the home page
    Navigator.pop(context, _currentImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Closet'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.asset(_currentImage),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text('Color', style: TextStyle(fontSize: 20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => _setColor('default'),
                      child: ClipOval(
                        child: Container(
                          color: Colors.brown,
                          width: 50,
                          height: 50,
                          child: _currentColor == 'default'
                              ? Icon(Icons.check)
                              : null,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _setColor('green'),
                      child: ClipOval(
                        child: Container(
                          color: Colors.green[200],
                          width: 50,
                          height: 50,
                          child: _currentColor == 'green'
                              ? Icon(Icons.check)
                              : null,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _setColor('blue'),
                      child: ClipOval(
                        child: Container(
                          color: Colors.blue[200],
                          width: 50,
                          height: 50,
                          child: _currentColor == 'blue'
                              ? Icon(Icons.check)
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text('Accessories', style: TextStyle(fontSize: 20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => _setAccessory('none'),
                      child: ClipOval(
                        child: Container(
                          color: Colors.transparent,
                          width: 50,
                          height: 50,
                          child: Image.asset('assets/icons/none.png'),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _setAccessory('hat'),
                      child: ClipOval(
                        child: Container(
                          color: Colors.transparent,
                          width: 50,
                          height: 50,
                          child: Image.asset('assets/icons/hat.png'),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _setAccessory('glasses'),
                      child: ClipOval(
                        child: Container(
                          color: Colors.transparent,
                          width: 50,
                          height: 50,
                          child: Image.asset('assets/icons/glasses.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _saveSelection,
              child: Text('Save'),
            ),
          ),
        ],
      ),
    );
  }
}
