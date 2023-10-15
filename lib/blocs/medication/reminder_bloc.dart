import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/blocs/medication/reminder_event.dart';
import 'package:flutter_application_1/blocs/medication/reminder_state.dart';
import 'package:flutter_application_1/repositories/medication_repository.dart';
import 'package:flutter_application_1/medication_model/medication.dart';

class MedicationBloc extends Bloc<MedicationEvent, MedicationState> {
  final MedicationRepository repository;

  MedicationBloc(this.repository) : super(MedicationInitial()) {
    
    on<LoadMedication>((event, emit) async {
      List<Medication> meds = await repository.getAllMedications();
      emit(MedicationLoaded(meds));
    });
  }
}