
import 'package:flutter/material.dart';

/// This is the Welcome Screen for the Meds Reminder App.
class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to Meds Reminder',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Your personal medication tracker.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 40), // This button will take you to the main page. 
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/main');
              },
              child: Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}