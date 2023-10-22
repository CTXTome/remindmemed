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
                    Navigator.of(context).pushNamed('/add');
                  },
                  child: Text('Add Medication'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: null,
                  child: Text('Edit Medication'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: null, //
                  child: Text('Delete Medication'),
                ),
              ]),
        ));
  }
}