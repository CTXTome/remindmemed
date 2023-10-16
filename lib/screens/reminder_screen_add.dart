import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/blocs/medication/reminder_event.dart';
import 'package:flutter_application_1/medication_model/medication.dart';
import 'package:flutter_application_1/blocs/medication/reminder_bloc.dart';

class AddMedicationScreen extends StatefulWidget {
  @override
  _AddMedicationScreenState createState() => _AddMedicationScreenState();
}

class _AddMedicationScreenState extends State<AddMedicationScreen> {
  File? _pickedImage;
  final TextEditingController _medicationController = TextEditingController();
  final TextEditingController _dosageController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  TimeOfDay? _selectedTime;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        _timeController.text = picked.format(context);
      });
    }
  }

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image); // only using images for file type for now

    if (result != null) {
      setState(() {
        _pickedImage = File(result.files.single.path!);
      });
    }
  }

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
                labelText:
                    'When to take it? (Click into the field to open the Date Picker.)',
                border: OutlineInputBorder(),
              ),
              readOnly: true,
              onTap: () => _selectTime(context),
            ),
            SizedBox(height: 10),
            (_pickedImage != null)
                ? Image.file(_pickedImage!,
                    height: 100, width: 100, fit: BoxFit.cover)
                : Container(
                    height: 100,
                    width: 100,
                    color: Colors.grey[200],
                    child: Icon(Icons.image, color: Colors.grey[500])),
            ElevatedButton(child: Text("Choose File"), onPressed: _pickImage),
            ElevatedButton(
              onPressed: () {
                final id = DateTime.now().millisecondsSinceEpoch;
                if (_selectedTime != null) {
                  DateTime dateTime = DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    DateTime.now().day,
                    _selectedTime!.hour,
                    _selectedTime!.minute,
                  );
                  final medication = Medication(
                    id: id,
                    name: _medicationController.text,
                    dosage: _dosageController.text,
                    time: dateTime,
                  );
                  BlocProvider.of<MedicationBloc>(context)
                      .add(AddMedication(medication));
                  Navigator.of(context).pop();
                } else {
                  //this is for errors if one were to occur
                  //child: const Text(
                  //'Incorrect settings applied.'
                  //);
                }
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
    if (medicationName.isNotEmpty) {}
  }

  @override
  void dispose() {
    _medicationController.dispose();
    super.dispose();
  }
}
