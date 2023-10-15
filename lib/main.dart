import 'package:flutter/material.dart';
import 'package:flutter_application_1/blocs/medication/reminder_event.dart';
import 'screens/reminder_screen_welcome.dart';
import 'screens/reminder_screen_main.dart';
import 'screens/reminder_screen_medications.dart';
import 'screens/reminder_screen_add.dart';
import 'package:flutter_application_1/repositories/medication_repository.dart';
import 'package:flutter_application_1/blocs/medication/reminder_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/blocs/medication/reminder_state.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context) => MedicationBloc(MedicationRepository()),
      child: MaterialApp(
        title: 'Meds Reminder',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        routes: {
          '/': (context) => WelcomeScreen(),
          '/main': (context) => BlocProvider(
            create: (context) => MedicationBloc(MedicationRepository()),
            child: MainScreen(),
          ),
          '/medications': (context) => BlocProvider(
            create: (context) => MedicationBloc(MedicationRepository()),
            child:  MyMedicationScreen(),
          ),
          '/add': (context) => BlocProvider(
                create: (context) => MedicationBloc(MedicationRepository()),
                child: AddMedicationScreen(),
              ),
        },
      ),
    );
  }
}
