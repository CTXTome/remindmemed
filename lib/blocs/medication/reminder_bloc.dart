///  DOCUMENTATION
///  reminder_bloc.dart file
/// 
/// 
/// Page Description:
/// This is the bloc architecture for the app.
/// This will handle the communication for the app between pages and the calls to the respository.
/// prints are being used to confirm certain events are behaving as expected.

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/blocs/medication/reminder_event.dart';
import 'package:flutter_application_1/blocs/medication/reminder_state.dart';
import 'package:flutter_application_1/repositories/medication_repository.dart';


class MedicationBloc extends Bloc<MedicationEvent, MedicationState> {
  final MedicationRepository repository;

  MedicationBloc(this.repository) : super(MedicationInitial()) {
    on<LoadMedication>((event, emit) async {
      print('adding event to repo');
      try {
        emit(MedicationLoading());
        final meds = await repository.getAllMedications();
        emit(MedicationLoaded(meds));
      } catch (_) {
        emit(MedicationError());
      }
    });

    on<AddMedication>((event, emit) async {
      print('adding event to repo');
      try {
        await repository.addMedication(event.medication);
        final meds = await repository.getAllMedications();
        emit(MedicationLoaded(meds));
      } catch (_) {
        emit(MedicationError());
      }
    });
    

  }
}
