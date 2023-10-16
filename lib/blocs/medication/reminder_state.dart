import 'package:flutter_application_1/medication_model/medication.dart';

abstract class MedicationState {}

class MedicationInitial extends MedicationState {}

class MedicationLoading extends MedicationState {}

class MedicationLoaded extends MedicationState {
  final List<Medication> medications;

  MedicationLoaded(this.medications);
}

class NoMedication extends MedicationState {}

class MedicationError extends MedicationState {}