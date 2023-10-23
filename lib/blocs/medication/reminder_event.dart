///  DOCUMENTATION
///  reminder_event.dart file
/// 
/// Page Description:
/// This page is for the bloc architecture and handles the events for different screens.
/// 

import 'package:flutter_application_1/medication_model/medication.dart';



abstract class MedicationEvent {}

class LoadMedication extends MedicationEvent {}

class AddMedication extends MedicationEvent {
  final Medication medication;

  AddMedication(this.medication);
}

class EditMedication extends MedicationEvent {}

class DeleteMedication extends MedicationEvent {}
