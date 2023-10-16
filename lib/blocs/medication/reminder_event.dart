import 'package:flutter_application_1/medication_model/medication.dart';



abstract class MedicationEvent {}

class LoadMedication extends MedicationEvent {}

class AddMedication extends MedicationEvent {
  final Medication medication;

  AddMedication(this.medication);
}

class EditMedication extends MedicationEvent {}

class DeleteMedication extends MedicationEvent {}
