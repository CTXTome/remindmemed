///  DOCUMENTATION
///  reminder_screen_main.dart file
/// 
/// Included functions in file:
/// Time Display that updates in 1 minute intervals.
/// Next medication based on chronological order for the time set in the "Add Medication" screen.
/// Bloc is used to pull the next medication to be displayed and listen for events 
/// 
/// 
/// 
/// 
/// Page Description:
/// This is the main screen that will display the current time, shows the next medication
/// and allows for navigation to the "My Medication" screen.




import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'reminder_screen_medications.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/blocs/medication/reminder_bloc.dart';
import 'package:flutter_application_1/blocs/medication/reminder_event.dart';
import 'package:flutter_application_1/blocs/medication/reminder_state.dart';
import 'package:flutter_application_1/medication_model/medication.dart';

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
            Text( // Displays the time on the main screen.
              DateFormat('h:mm a').format(DateTime.now()),
              style: TextStyle(fontSize: 48),
            ),
            SizedBox(height: 20), // This allows for the diplay of medication based on chronological order fo the time on the medication.
            BlocBuilder<MedicationBloc, MedicationState>(
              builder: (context, state) {
                if (state is MedicationLoading) {
                  return CircularProgressIndicator();
                }

                final DateTime now = DateTime.now();
                Medication? nextMedication;

                if (state is MedicationLoaded && state.medications.isNotEmpty) {
                  // Sort medications by time
                  List<Medication> sortedMedications =
                      List.from(state.medications)
                        ..sort((a, b) => a.time.compareTo(b.time));

                  // Find the next upcoming medication
                  for (var med in sortedMedications) {
                    if (med.time.isAfter(now)) {
                      nextMedication = med;
                      break;
                    }
                  }
                }

                if (nextMedication != null) { ///Card to display the next medication.
                  return Align(
                    alignment: Alignment.center,
                    child: Container(
                        width: 250,
                        child: Card(
                            child: ListTile(
                          title: Text("Next Med: ${nextMedication.name}"),
                          subtitle: Text(
                              "@ ${DateFormat('h:mm a').format(nextMedication.time)}"),
                        ))),
                  );
                } else {
                  return Text('No upcoming medications.');
                }
              },
            ),
            SizedBox(height: 20), //This button will allow you to go to the "My Medication" screen.
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => MyMedicationScreen()),
                    (Route<dynamic> route) => route.isFirst);
              },
              child: Text('My Medication'),
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
