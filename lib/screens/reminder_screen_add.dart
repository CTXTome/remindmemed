///  DOCUMENTATION
///  reminder_screen_main.dart file
/// 
/// Included functions in file:
/// Add Medication to the repository.
/// Bloc is used here to capture the medication and display in the main and my medication pages.
/// Time picker is provided to capture timestamp for the medication, there is an an analog and digital option to input time.
/// A unique id will be created to capture the name, dosage and time then stored in the repository.
/// App Bar allows for navigation back to the previous page and a home button to return to the main page.
/// 
/// Page Description:
/// This page allows for the user to add their medication to be displayed in the "Main" and "My Medication" screens.
/// The user will input the name, dosage amount, time and upload an image (display of the image will be included at a later date)
/// Names are recommend to be unique though they are not required. 
/// 



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

  Future<void> _selectTime(BuildContext context) async {//this is for the TimePicker to start with the current time.
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
      appBar: AppBar(
        title: Text('Add Medication'),
        actions: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.of(context).pushNamed('/main');
              },
            ),
          ],),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(//User inputs the name of the medication.
              controller: _medicationController,
              decoration: InputDecoration(
                labelText: 'Medication Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0), //User inputs Dosage amount.
            TextField(
              controller: _dosageController,
              decoration: InputDecoration(
                labelText: 'Dosage Amount',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),//User can use an interactive analog clock or input in the digital clock the time needed to take their meds.
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
            SizedBox(height: 10), // This button will allow for images to be uploaded. However, the feature for displaying on the medication card will not be used at this time. 
            (_pickedImage != null)
                ? Image.file(_pickedImage!,
                    height: 100, width: 100, fit: BoxFit.cover)
                : Container(
                    height: 100,
                    width: 100,
                    color: Colors.grey[200],
                    child: Icon(Icons.image, color: Colors.grey[500])),
            ElevatedButton(child: Text("Choose File"), onPressed: _pickImage),
            SizedBox(height: 10), //This is used to add the medication into the repository and bloc
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
