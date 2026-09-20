import 'package:flutter/material.dart';
import '../../../../shared/widgets/layouts/web_layout.dart';
import '../../../../shared/widgets/layouts/apple_header.dart';
import '../../../../shared/widgets/buttons/apple_button.dart';
import '../../../../shared/widgets/forms/apple_top_label_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _institutionController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _institutionController.dispose();
    super.dispose();
  }

  void _register() {
    // Implement register logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 24.0, right: 36.0, left: 36.0),
              child: AppleHeader(
                showBackButton: true,
                title: 'Registrar usuario',
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            WebLayout(
                              maxWidth: 600,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0,
                                  vertical: 32.0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    const SizedBox(height: 20),
                                    AppleTopLabelField(
                                      controller: _usernameController,
                                      label: 'Nombre de usuario',
                                    ),
                                    const SizedBox(height: 24),
                                    AppleTopLabelField(
                                      controller: _emailController,
                                      label: 'Correo electrónico',
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    const SizedBox(height: 24),
                                    AppleTopLabelField(
                                      controller: _institutionController,
                                      label: 'Institución educativa',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            
                            const Spacer(flex: 1),
                            
                            Padding(
                              padding: const EdgeInsets.only(right: 36.0, bottom: 32.0),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: AppleButton(
                                  text: 'Registrar Usuario',
                                  onPressed: _register,
                                  isFullWidth: false,
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
          ],
        ),
      ),
    );
  }
}
