import 'package:flutter/material.dart';
import '../../../home/presentation/screens/mobile_home_screen.dart';
import '../../../../shared/widgets/buttons/apple_button.dart';
import '../../../../shared/widgets/layouts/web_layout.dart';

/// Confirmation for the prototype's simulated synchronization results.
class SyncSuccessScreen extends StatelessWidget {
  const SyncSuccessScreen({
    super.key,
    required this.alarmCount,
    required this.courseCount,
    required this.activityCount,
  });

  final int alarmCount;
  final int courseCount;
  final int activityCount;

  @override
  Widget build(BuildContext context) {
    const regular = TextStyle(fontSize: 20, height: 1.3, color: Colors.black87);
    const emphasis = TextStyle(
      fontSize: 20,
      height: 1.3,
      fontWeight: FontWeight.w700,
      color: Colors.black87,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: WebLayout(
          child: LayoutBuilder(
            builder: (context, constraints) => SizedBox(
              height: constraints.maxHeight,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: (constraints.maxHeight * .045).clamp(0.0, 36.0),
                    ),
                    const _WeatherLogo(),
                    const SizedBox(height: 32),
                    const Text(
                      'Sincronizado',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF007AFF),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Se han agregado',
                      style: regular,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    Text(
                      '$alarmCount ${alarmCount == 1 ? 'alarma' : 'alarmas'}',
                      style: emphasis,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    Text(
                      '$courseCount ${courseCount == 1 ? 'asignatura' : 'asignaturas'} con',
                      style: regular,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    Text(
                      '$activityCount ${activityCount == 1 ? 'Actividad' : 'Actividades'}',
                      style: emphasis,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      width: 180,
                      child: Divider(height: 16, color: Color(0xFFE5E5EA)),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Para ver todo el detalle revisa\nla aplicación web',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.3,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 76),
                    AppleButton(
                      text: 'Entendido',
                      height: 46,
                      isFullWidth: false,
                      onPressed: () => Navigator.pushAndRemoveUntil<void>(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MobileHomeScreen(),
                        ),
                        (route) => false,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Demostración: no se han creado alarmas reales.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _WeatherLogo extends StatelessWidget {
  const _WeatherLogo();

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF35C5F3), Color(0xFF007AFF)],
        ),
      ),
      child: const Stack(
        children: [
          Positioned(
            right: 7,
            top: 9,
            child: Icon(Icons.circle, color: Color(0xFFFFD60A), size: 26),
          ),
          Positioned(
            left: 5,
            bottom: 7,
            child: Icon(Icons.cloud, color: Color(0xFFE1F1FA), size: 43),
          ),
        ],
      ),
    ),
  );
}
