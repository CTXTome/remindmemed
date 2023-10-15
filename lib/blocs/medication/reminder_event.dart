import 'package:flutter_application_1/medication_model/medication.dart';
import 'package:flutter_application_1/repositories/medication_repository.dart';
import 'package:flutter_application_1/blocs/medication/reminder_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


abstract class MedicationEvent {}

class LoadMedication extends MedicationEvent {}

class AddMedication extends MedicationEvent {
  final Medication medication;

  AddMedication(this.medication);
}

class EditMedication extends MedicationEvent {}

class DeleteMedication extends MedicationEvent {}
