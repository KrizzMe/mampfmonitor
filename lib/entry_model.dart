
class Entry {
  String? meal;
  String? notes;
  String? medication;
  DateTime? timestamp;

  Entry({this.meal, this.notes, this.medication, this.timestamp});

  Map<String, dynamic> toJson() => {
    'meal': meal,
    'notes': notes,
    'medication': medication,
    'timestamp': timestamp?.toIso8601String(),
  };

  static Entry fromJson(Map<String, dynamic> json) => Entry(
    meal: json['meal'],
    notes: json['notes'],
    medication: json['medication'],
    timestamp: DateTime.tryParse(json['timestamp'] ?? ''),
  );
}
