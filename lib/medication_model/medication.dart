class Medication {
  final int id;
  final String name;
  final DateTime time;
  final String dosage;
  
  Medication({required this.id, required this.name, required this.time, required this.dosage});
  
  Medication copyWith({
    int? id,
    String? name,
    DateTime? time,
    String? dosage,
  }) {
    return Medication(
      id: id ?? this.id,
      name: name ?? this.name,
      time: time ?? this.time,
      dosage: dosage ?? this.dosage,
    );
  }
}
