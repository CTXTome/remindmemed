import 'package:flutter_application_1/medication_model/medication.dart';

class MedicationRepository {
  final List<Medication> _store = [];

  Future<void> addMedication(Medication medication) async {
    _store.add(medication);
  }

  Future<List<Medication>> getAllMedications() async {
    return _store;
  }


  Future<void> updateMedication(Medication updatedMedication) async {
    for (int i = 0; i < _store.length; i++) {
      if (_store[i].name == updatedMedication.name) {
        _store[i] = updatedMedication;
        break;
      }
    }
  }

  Future<void> deleteMedication(int id) async {
    _store.removeWhere((medication) => medication.name == id);
  }
}