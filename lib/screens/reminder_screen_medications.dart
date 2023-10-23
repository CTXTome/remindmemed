///  DOCUMENTATION
///  reminder_screen_medications.dart file
/// 
/// Included functions in file:
/// 
/// App Bar allows for navigation back to the previous page and a home button to return to the main page.
/// Displays a list of medication based on the time medication needs to be taken next.
/// Bloc architecture is in place to call the repository and display all medication.
/// 
/// 
/// Page Description:
/// This page will display a list view of all medication that has been added in chronological order based on the time set.
/// This page also allows for user to navigate to the add medication page.
/// 


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/blocs/medication/reminder_bloc.dart';
import 'package:flutter_application_1/blocs/medication/reminder_state.dart';

class MyMedicationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.of(context).pushNamed('/main');
              },
            ),
          ],
          title: Text('My Medication'),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20),
                BlocBuilder<MedicationBloc, MedicationState>(
                  builder: (context, state) {
                    if (state is MedicationLoading) {
                      return CircularProgressIndicator();
                    } else if (state is MedicationLoaded &&
                        state.medications.isNotEmpty) {
                      // Sort medications by their set time
                      final sortedMedications = state.medications
                        ..sort((a, b) => a.time.compareTo(b.time));

                      return Container(
                          height: 350,
                          child: ListView.builder( //Display for each medication that has been added based on the time meds need to be taken.
                            itemCount: sortedMedications.length,
                            itemBuilder: (context, index) {
                              final medication = sortedMedications[index];
                              return Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: 250,
                                    child: Card(
                                      child: ListTile(
                                        title: Text("Med: ${medication.name}"),
                                        subtitle: Text(
                                            "@ ${DateFormat('h:mm a').format(medication.time)}"),
                                      ),
                                    ),
                                  ));
                            },
                          ));
                    } else {
                      return Text('No upcoming medications.');
                    }
                  },
                ),
                SizedBox(height: 20), //This button will add the medication into the reposirtory and return user to the "My Medication" screen.
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/add');
                  },
                  child: Text('Add Medication'),
                ),
               
              ]),
        ));
  }
}
