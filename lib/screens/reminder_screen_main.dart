import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'reminder_screen_medications.dart';
import 'dart:async';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // timer to update the time in main screen
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Meds Reminder")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              DateFormat('h:mm a').format(DateTime.now()),
              style: TextStyle(fontSize: 48),
            ),
            SizedBox(height: 20),
            Card(
              child: ListTile(
                title: Text("Next Med: Xarelto"),
                subtitle: Text("@ 10:30 AM"),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => MyMedicationScreen()),
                  (Route<dynamic> route) => route.isFirst
                  );
              },
              child: Text('My Medication'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: null, // makes the button inactive
              child: Text('History'),
            ),
          ],
        ),
      ),
    );
  }

   @override
  void dispose() {
    // Dispose of the timer to prevent memory leaks
    _timer?.cancel();
    super.dispose();
  }

}
