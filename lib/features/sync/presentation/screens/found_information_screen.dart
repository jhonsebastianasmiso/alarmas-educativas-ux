import 'sync_success_screen.dart';
import '../../../../shared/widgets/layouts/mobile_flow_header.dart';
import 'package:flutter/material.dart';
import '../../../../shared/widgets/buttons/apple_button.dart';
import '../../../../shared/widgets/layouts/web_layout.dart';

class FoundInformationScreen extends StatefulWidget {
  const FoundInformationScreen({super.key});

  @override
  State<FoundInformationScreen> createState() => _FoundInformationScreenState();
}

class _FoundInformationScreenState extends State<FoundInformationScreen> {
  static const _courses = [
    'UX mejoramiento de las experiencias de usuario',
    'Prácticas esenciales para el desarrollo de software',
    'Principios de diseño de software',
    'Arquitectura para Big Data',
  ];
  final Set<int> _selected = {0, 1, 2};
  String? _error;

  void _createAlarms() {
    if (_selected.isEmpty) {
      setState(() => _error = 'Selecciona al menos un curso.');
      return;
    }
    // Simulated per-course totals; the initial three selections match the mockup.
    const alarmCounts = [17, 18, 15, 12];
    const activityCounts = [10, 10, 10, 8];
    Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (_) => SyncSuccessScreen(
          alarmCount: _selected.fold<int>(
            0,
            (total, index) => total + alarmCounts[index],
          ),
          courseCount: _selected.length,
          activityCount: _selected.fold<int>(
            0,
            (total, index) => total + activityCounts[index],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: WebLayout(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const MobileFlowHeader(title: 'Información\nencontrada'),
              const SizedBox(height: 96),
              const Text(
                'Selecciona la información a\nsincronizar',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, height: 1.2),
              ),
              const SizedBox(height: 32),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'Cursos:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 12),
              for (var index = 0; index < _courses.length; index++)
                CheckboxListTile(
                  title: Tooltip(
                    message: _courses[index],
                    child: Text(
                      _courses[index],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 17, color: Colors.black),
                    ),
                  ),
                  activeColor: const Color(0xFF007AFF),
                  checkboxShape: const CircleBorder(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  dense: true,
                  value: _selected.contains(index),
                  onChanged: (checked) => setState(() {
                    if (checked == true) {
                      _selected.add(index);
                    } else {
                      _selected.remove(index);
                    }
                    _error = null;
                  }),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              if (_error != null)
                Semantics(
                  liveRegion: true,
                  child: Text(
                    _error!,
                    style: const TextStyle(color: Color(0xFFB3261E)),
                  ),
                ),
              const SizedBox(height: 56),
              Center(
                child: AppleButton(
                  text: 'Crear Alarmas',
                  height: 44,
                  isFullWidth: false,
                  onPressed: _createAlarms,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Cursos de ejemplo',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
