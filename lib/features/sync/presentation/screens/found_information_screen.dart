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
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cursos seleccionados'),
        content: SingleChildScrollView(
          child: Text('${[for (var i = 0; i < _courses.length; i++) if (_selected.contains(i)) _courses[i]].join('\n\n')}\n\nEstos cursos son de ejemplo. La creación de alarmas desde una plataforma aún no está disponible.'),
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Entendido'))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: WebLayout(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(children: [
                BackButton(onPressed: () => Navigator.maybePop(context)),
                const Expanded(child: Text('Información encontrada')),
              ]),
              const SizedBox(height: 32),
              const Text('Selecciona la información a sincronizar', textAlign: TextAlign.center),
              const SizedBox(height: 32),
              const Text('Cursos:'),
              for (var index = 0; index < _courses.length; index++)
                CheckboxListTile(
                  title: Text(_courses[index]),
                  value: _selected.contains(index),
                  onChanged: (checked) => setState(() {
                    if (checked == true) { _selected.add(index); } else { _selected.remove(index); }
                    _error = null;
                  }),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              if (_error != null) Semantics(liveRegion: true, child: Text(_error!)),
              const SizedBox(height: 32),
              Center(child: AppleButton(text: 'Crear Alarmas', isFullWidth: false, onPressed: _createAlarms)),
              const SizedBox(height: 16),
              const Text('Cursos de ejemplo', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.black54)),
            ],
          ),
        ),
      ),
    ),
  );
}
