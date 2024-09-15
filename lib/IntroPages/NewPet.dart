import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart'; // Import Lottie package
import '../home_page.dart';

class NewPet extends StatefulWidget {
  const NewPet({Key? key}) : super(key: key);

  @override
  _NewPetState createState() => _NewPetState();
}

class _NewPetState extends State<NewPet> {
  final _formKey = GlobalKey<FormState>();
  String _petName = '';

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 500),
          pageBuilder: (_, __, ___) =>
              HomePage(petName: _petName, birthDate: DateTime.now()),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 253, 208, 1.0),
      body: Stack(
        children: [
          // Lottie animation background
          Lottie.asset(
            'assets/Lottie/Animation - greenish clouds.json',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Image in the middle
                    Image.asset(
                      'assets/images/dino_name.png',
                      height: 200,
                      width: 200,
                    ),
                    SizedBox(height: 20),
                    // Bold text
                    Text(
                      'What do you want to name your Dino Nugget?',
                      style: GoogleFonts.varelaRound(
                        fontSize: 24,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    // Normal text
                    SizedBox(height: 20),
                    // Form input
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _petName = value!;
                      },
                    ),
                    SizedBox(height: 20),
                    // Submit button
                    ElevatedButton(
                      onPressed: _submit,
                      child: Text(
                        'Start',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'Arial',
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
