import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/blocs/medication/reminder_event.dart';
import 'package:flutter_application_1/medication_model/medication.dart';
import 'package:flutter_application_1/blocs/medication/reminder_bloc.dart';
import 'package:flutter_application_1/blocs/medication/reminder_state.dart';



class AddMedicationScreen extends StatefulWidget {
  @override
  _AddMedicationScreenState createState() => _AddMedicationScreenState();
}

class _AddMedicationScreenState extends State<AddMedicationScreen> {
  final TextEditingController _medicationController = TextEditingController();
  final TextEditingController _dosageController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Medication')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _medicationController,
              decoration: InputDecoration(
                labelText: 'Medication Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _dosageController,
              decoration: InputDecoration(
                labelText: 'Dosage Amount',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(
                labelText: 'When to take it?',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final medication = Medication(
                  name: _medicationController.text,
                  dosage: _dosageController.text,
                  time: DateTime.now(), 
                  );
                  BlocProvider.of<MedicationBloc>(context).add(AddMedication(medication)); //something is broken here between the state and bloc that I cannot figure out
                  Navigator.of(context).pop();
              },
                  child: Text('Add Medication'),
                  ),
          ],
        ),
      ),
    );
  }

  void _addMedication() {

    String medicationName = _medicationController.text;
    if (medicationName.isNotEmpty) {
    }
  }

  @override
  void dispose() {
    _medicationController.dispose();
    super.dispose();
  }
}
