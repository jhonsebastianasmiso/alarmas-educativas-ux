import 'package:alarmas_educativas/features/alarms/presentation/screens/create_alarm_screen.dart';
import 'package:flutter/material.dart';
import '../../../../shared/widgets/layouts/apple_main_header.dart';
import '../../../../shared/widgets/buttons/apple_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 36.0,
                vertical: 16.0,
              ),
              child: AppleMainHeader(
                currentScreen: 'home',
                rightActionWidget: AppleButton(
                  text: 'Crear Alarma',
                  isFullWidth: false,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreateAlarmScreen(),
                      ),
                    );
                  },
                ),
              ),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  'Inicio vacío',
                  style: TextStyle(color: Colors.black54, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
