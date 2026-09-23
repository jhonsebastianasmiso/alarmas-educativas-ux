import 'package:flutter/material.dart';
import '../../../../shared/widgets/buttons/apple_button.dart';
import '../../../../shared/widgets/layouts/web_layout.dart';

class SyncSuccessScreen extends StatelessWidget {
  const SyncSuccessScreen({super.key, required this.alarmCount, required this.courseCount, required this.activityCount});
  final int alarmCount;
  final int courseCount;
  final int activityCount;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(child: WebLayout(child: SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(children: [
        const Text('Sincronizado'),
        const Text('Se han agregado'),
        Text('$alarmCount ${alarmCount == 1 ? 'alarma' : 'alarmas'}'),
        Text('$courseCount ${courseCount == 1 ? 'asignatura' : 'asignaturas'} con'),
        Text('$activityCount ${activityCount == 1 ? 'Actividad' : 'Actividades'}'),
        const Text('Para ver todo el detalle revisa\nla aplicación web', textAlign: TextAlign.center),
        AppleButton(text: 'Entendido', isFullWidth: false, onPressed: () => Navigator.maybePop(context)),
        const Text('Demostración: no se han creado alarmas reales.'),
      ]),
    ))),
  );
}
