import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/blocs/medication/reminder_event.dart';
import 'package:flutter_application_1/blocs/medication/reminder_state.dart';
import 'package:flutter_application_1/repositories/medication_repository.dart';
import 'package:flutter_application_1/medication_model/medication.dart';

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
    
    //Stream<MedicationState> _mapLoadMedicationToState() async* {
     // print('adding event to repo');
     // yield MedicationLoading();
     // try {
      //  MedicationRepository repository = MedicationRepository();
     //   List<Medication> medications = await repository.getAllMedications();
     //   medications.sort((a, b) => a.time.compareTo(b.time));

      //  Medication? nextMedication;
      //  DateTime now = DateTime.now();

      //  for (Medication med in medications) {
      //    if (med.time.isAfter(now)) {
       //     nextMedication = med;
       //     break;
     //     }
    //    }

     //   if (nextMedication != null) {
   //       yield MedicationLoaded([nextMedication]);
   //     } else {
   //       yield NoMedication();
   //     }
   //   } catch (e) {
    //    yield MedicationError();
  //    }
 //   }
  }
}
