import 'package:cloud_firestore/cloud_firestore.dart';

class SensorModel {
  final DateTime createdAt;
  final String name;
  final String serial;
  final bool status;

  SensorModel({
    required this.createdAt,
    required this.name,
    required this.serial,
    required this.status,
  });

  factory SensorModel.empty() {
    return SensorModel(
      createdAt: DateTime.now(),
      name: "",
      serial: "",
      status: false,
    );
  }

  factory SensorModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return SensorModel.empty();

    DateTime getDate(Timestamp? date) {
      return date?.toDate() ?? DateTime.now();
    }

    return SensorModel(
      createdAt: getDate(json['CreatedAt']),
      name: json['Name'] ?? "",
      serial: json['Serial'] ?? "",
      status: json['Status'] ?? false,
    );
  }
}
