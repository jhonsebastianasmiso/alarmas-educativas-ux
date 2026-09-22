import 'package:flutter/material.dart';
import '../../../../shared/widgets/buttons/apple_button.dart';
import '../../../../shared/widgets/forms/apple_style_form.dart';
import '../../../../shared/widgets/layouts/web_layout.dart';

class MobileConnectScreen extends StatefulWidget {
  const MobileConnectScreen({super.key});

  @override
  State<MobileConnectScreen> createState() => _MobileConnectScreenState();
}

class _MobileConnectScreenState extends State<MobileConnectScreen> {
  final _platformController = TextEditingController();
  final _emailController = TextEditingController();
  bool _acceptedTerms = false;

  @override
  void dispose() {
    _platformController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _startSync() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: WebLayout(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Row(children: [
                  BackButton(onPressed: () => Navigator.maybePop(context)),
                  const Text('Conectar'),
                ]),
                const SizedBox(height: 32),
                const Text('Sincroniza tus actividades y crea alarmas para no faltar a ninguna entrega', textAlign: TextAlign.center),
                const SizedBox(height: 32),
                AppleFormGroup(children: [
                  AppleFormField(label: 'Plataforma:', labelWidth: 92, controller: _platformController, showClearButton: true),
                  AppleFormField(label: 'Correo asociado:', labelWidth: 136, controller: _emailController, keyboardType: TextInputType.emailAddress),
                ]),
                const SizedBox(height: 20),
                CheckboxListTile(
                  title: const Text('Aceptar términos y condiciones'),
                  value: _acceptedTerms,
                  onChanged: (value) => setState(() => _acceptedTerms = value ?? false),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
                const SizedBox(height: 32),
                AppleButton(text: 'Iniciar sincronización', isFullWidth: false, onPressed: _startSync),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
