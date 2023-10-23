/***************************************************************************************************
 * DOCUMENTATION
 * 
 * main.dart file
 * 
 * Included functions in file:
 * runApp
 * Title and Theme for app to be use in App Bar.
 * Routes for page navigation.
 * 
 * 
 * App Description:
 * This application helps users manage their medications, providing reminders 
 * and allowing users to add, edit, and remove medications.
 * 
 * Author: Tome Johnson
 * Date: 10/22/2023
 
 ****************************************************************************************************/


import 'package:flutter/material.dart';
import 'screens/reminder_screen_welcome.dart';
import 'screens/reminder_screen_main.dart';
import 'screens/reminder_screen_medications.dart';
import 'screens/reminder_screen_add.dart';
import 'package:flutter_application_1/repositories/medication_repository.dart';
import 'package:flutter_application_1/blocs/medication/reminder_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() => runApp(MyApp());

final medicationRepository = MedicationRepository();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MedicationBloc(medicationRepository),
      child: MaterialApp(
        title: 'Meds Reminder',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        routes: {
          '/': (context) => WelcomeScreen(), //start screen
          '/main': (context) => MainScreen(), //main screen
          '/medications': (context) => MyMedicationScreen(), //Medication list screen
          '/add': (context) => AddMedicationScreen(), //Add Medication screen
        },
      ),
    );
  }
}

