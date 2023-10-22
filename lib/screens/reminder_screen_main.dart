import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'reminder_screen_medications.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/blocs/medication/reminder_bloc.dart';
import 'package:flutter_application_1/blocs/medication/reminder_event.dart';
import 'package:flutter_application_1/blocs/medication/reminder_state.dart';
import 'reminder_screen_test.dart';

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
    MedicationBloc bloc = BlocProvider.of<MedicationBloc>(context);
    bloc.add(LoadMedication());
    // timer to update the time in main screen
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Meds Reminder")),
      body: Center(
        child: Column(
          children: [
            Text(
              DateFormat('h:mm a').format(DateTime.now()),
              style: TextStyle(fontSize: 48),
            ),
            SizedBox(height: 20),
            BlocBuilder<MedicationBloc, MedicationState>(
              builder: (context, state) {
                if (state is MedicationLoading) {
                  return CircularProgressIndicator();
                } else if (state is MedicationLoaded &&
                    state.medications.isNotEmpty) {
                  final nextMedication = state.medications[
                      0]; // or however you determine the "next" medication
                  return Card(
                    child: ListTile(
                      title: Text("Next Med: ${nextMedication.name}"),
                      subtitle: Text(
                          "@ ${DateFormat('h:mm a').format(nextMedication.time)}"),
                    ),
                  );
                } else {
                  return Text('No upcoming medications.');
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => MyMedicationScreen()),
                    (Route<dynamic> route) => route.isFirst);
              },
              child: Text('My Medication'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => TestScreen()));
              },
              child: Text('Test Navigation'),
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
