import 'package:flutter/material.dart';
import '../../domain/alarm_data.dart';
import 'alarm_form_screen.dart';

class EditAlarmScreen extends StatelessWidget {
  const EditAlarmScreen({super.key, required this.alarm});
  final AlarmData alarm;

  @override
  Widget build(BuildContext context) => AlarmFormScreen(initialAlarm: alarm);
}
