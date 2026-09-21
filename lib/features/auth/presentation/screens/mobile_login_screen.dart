import 'package:alarmas_educativas/features/home/presentation/screens/mobile_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../../shared/widgets/forms/apple_style_form.dart';
import '../../../../shared/widgets/buttons/apple_button.dart';
import 'recover_password_screen.dart';
import 'register_screen.dart';

class MobileLoginScreen extends StatefulWidget {
  const MobileLoginScreen({super.key});

  @override
  State<MobileLoginScreen> createState() => _MobileLoginScreenState();
}

class _MobileLoginScreenState extends State<MobileLoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final Color primaryBlue = const Color(0xFF007AFF);

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MobileHomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF9F9F9,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      const Spacer(),
                      SizedBox(
                        height: 160,
                        width: 200,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.cloud,
                              size: 180,
                              color: primaryBlue,
                            ),
                            Positioned(
                              bottom: 25,
                              child: Icon(
                                Icons.person,
                                size: 70,
                                color: primaryBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),

                      AppleFormGroup(
                        children: [
                          AppleFormField(
                            controller: _usernameController,
                            label: 'Usuario:',
                            showClearButton: true,
                          ),
                          AppleFormField(
                            controller: _passwordController,
                            label: 'Contraseña:',
                            obscureText: true,
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const RecoverPasswordScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Recuperar clave',
                            style: TextStyle(
                              color: primaryBlue,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      AppleButton(
                        text: 'Iniciar sesión',
                        onPressed: _login,
                        isFullWidth: false,
                      ),

                      const Spacer(),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 40.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Registrarse (web)',
                            style: TextStyle(
                              color: primaryBlue,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
