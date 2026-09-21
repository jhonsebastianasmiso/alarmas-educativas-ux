import 'package:flutter/material.dart';

class AlarmData {
  const AlarmData({
    required this.name,
    required this.details,
    required this.date,
    required this.time,
    this.colorName = 'Azul',
    this.color = const Color(0xFF007AFF),
    this.days = const [],
  });
  final String name;
  final String details;
  final DateTime date;
  final TimeOfDay time;
  final String colorName;
  final Color color;
  final List<String> days;
}
