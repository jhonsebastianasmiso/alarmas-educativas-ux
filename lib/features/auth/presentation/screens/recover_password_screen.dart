import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../../shared/widgets/forms/apple_style_form.dart';
import '../../../../shared/widgets/layouts/web_layout.dart';
import '../../../../shared/widgets/layouts/apple_header.dart';
import '../../../../shared/widgets/buttons/apple_button.dart';
import 'success_message_screen.dart';

class RecoverPasswordScreen extends StatefulWidget {
  const RecoverPasswordScreen({super.key});

  @override
  State<RecoverPasswordScreen> createState() => _RecoverPasswordScreenState();
}

class _RecoverPasswordScreenState extends State<RecoverPasswordScreen> {
  final _emailController = TextEditingController();
  final Color primaryBlue = const Color(0xFF007AFF);

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _recoverPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SuccessMessageScreen(
          title: 'Correo enviado',
          message:
              'Se ha enviado un correo a su cuenta asociada con las instrucciones para recuperar su contraseña.\n\nPor favor, revise su bandeja de entrada y la carpeta de spam.',
          icon: CupertinoIcons.mail,
          buttonText: 'Volver al inicio',
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF9F9F9,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 24.0, right: 36.0),
              child: AppleHeader(showBackButton: true),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return WebLayout(
                    maxWidth: 600,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 24.0,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight - 48,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Spacer(flex: 1),

                              const Text(
                                'Ingrese correo o nombre de usuario para recuperar contraseña',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),

                              const SizedBox(height: 40),

                              AppleFormGroup(
                                children: [
                                  AppleFormField(
                                    controller: _emailController,
                                    label: 'Correo/Usuario:',
                                    showClearButton: true,
                                    labelWidth: 130.0,
                                  ),
                                ],
                              ),

                              const SizedBox(height: 50),

                              AppleButton(
                                text: 'Enviar',
                                onPressed: _recoverPassword,
                                isFullWidth: false,
                              ),

                              const Spacer(flex: 2),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
