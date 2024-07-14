import 'package:flutter/material.dart';
import 'HomePage.dart';

class NewPet extends StatefulWidget {
  const NewPet({super.key});

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
        MaterialPageRoute(
          builder: (context) =>
              HomePage(petName: _petName, birthDate: DateTime.now()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Name your dino nugget',
                      border: OutlineInputBorder()),
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
                ElevatedButton(
                  onPressed: _submit,
                  child: Text('Start'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
