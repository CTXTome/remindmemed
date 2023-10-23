///  DOCUMENTATION
///  medication_repository.dart file
/// 
/// Page Description:
/// This page handles the respository for the app. At this time, Update and Delete are not functions of the app. These will be added at a later date. 
/// 


import 'package:flutter_application_1/medication_model/medication.dart';

class MedicationRepository {
  final List<Medication> _store = [];
  
  int _currentId = 0;
  Future<void> addMedication(Medication medication) async {
    _store.add(medication.copyWith(id: _currentId++));
    print('Medication has been added.');
  }

  Future<List<Medication>> getAllMedications() async {
    return _store;
  }


  Future<void> updateMedication(Medication updatedMedication) async { //This part of the app will be added at a later date
    for (int i = 0; i < _store.length; i++) {
      if (_store[i].name == updatedMedication.name) {
        _store[i] = updatedMedication;
        break;
      }
    }
  }

  Future<void> deleteMedication(int id) async { //This part of the app will be added at a later date.
    _store.removeWhere((medication) => medication.id == id);
  }
}