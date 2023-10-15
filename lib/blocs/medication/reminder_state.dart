import 'package:flutter_application_1/medication_model/medication.dart';

abstract class MedicationState {}

class MedicationInitial extends MedicationState {}

class MedicationLoaded extends MedicationState {
  final List<Medication> medications;  
  MedicationLoaded(this.medications);
}
