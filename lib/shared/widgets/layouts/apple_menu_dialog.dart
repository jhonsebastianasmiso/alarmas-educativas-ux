import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../features/home/presentation/screens/home_web.dart';
import '../../../features/alarms/presentation/screens/create_alarm_screen.dart';
import '../../../features/auth/presentation/screens/login_screen.dart';

void showAppleMenu(BuildContext context, {required String currentScreen}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Cerrar Menú',
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ),
          
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: SizedBox(
                  height: 60,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedIcon(
                            icon: AnimatedIcons.menu_close,
                            progress: animation,
                            size: 32,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Menú',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 90.0, left: 24.0),
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: 320,
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.black.withOpacity(0.05)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _MenuOption(
                          text: 'Menú principal',
                          onTap: () {
                            if (currentScreen == 'home') {
                              Navigator.pop(context);
                            } else {
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const HomeWeb()),
                              );
                            }
                          },
                        ),
                        _MenuOption(
                          text: 'Crear alarma',
                          onTap: () {
                            if (currentScreen == 'create_alarm') {
                              Navigator.pop(context);
                            } else {
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const CreateAlarmScreen()),
                              );
                            }
                          },
                        ),
                        _MenuOption(
                          text: 'Ir a mobile',
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        _MenuOption(
                          text: 'Cerrar sesión',
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                              (route) => false,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

class _MenuOption extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const _MenuOption({required this.text, required this.onTap});

  @override
  State<_MenuOption> createState() => _MenuOptionState();
}

class _MenuOptionState extends State<_MenuOption> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          decoration: BoxDecoration(
            color: _isHovered ? Colors.black.withOpacity(0.04) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              widget.text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
