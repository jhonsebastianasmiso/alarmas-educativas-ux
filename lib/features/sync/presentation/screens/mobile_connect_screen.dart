import 'package:flutter/material.dart';
import '../../../../shared/widgets/buttons/apple_button.dart';
import '../../../../shared/widgets/forms/apple_style_form.dart';
import '../../../../shared/widgets/layouts/web_layout.dart';
import '../../../../shared/widgets/layouts/apple_header.dart';

class MobileConnectScreen extends StatefulWidget {
  const MobileConnectScreen({super.key});

  @override
  State<MobileConnectScreen> createState() => _MobileConnectScreenState();
}

class _MobileConnectScreenState extends State<MobileConnectScreen> {
  final _platformController = TextEditingController();
  final _emailController = TextEditingController();
  bool _acceptedTerms = false;
  String? _error;

  @override
  void dispose() {
    _platformController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _startSync() {
    FocusScope.of(context).unfocus();
    final platform = _platformController.text.trim();
    final email = _emailController.text.trim();
    String? error;
    if (platform.isEmpty) {
      error = 'Ingresa la plataforma que deseas conectar.';
    } else if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email)) {
      error = 'Ingresa un correo asociado válido.';
    } else if (!_acceptedTerms) {
      error = 'Acepta los términos y condiciones para continuar.';
    }
    setState(() => _error = error);
    if (error != null) return;
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sincronización no disponible'),
        content: const Text(
          'La conexión con plataformas aún no está habilitada. No se han enviado tus datos ni sincronizado actividades.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Entendido'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: WebLayout(
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(32, 12, 32, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      const AppleHeader(
                        title: 'Conectar',
                        showBackButton: false,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          tooltip: 'Volver',
                          padding: EdgeInsets.zero,
                          onPressed: () => Navigator.maybePop(context),
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 28,
                            color: Color(0xFF007AFF),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: (constraints.maxHeight * .15).clamp(32.0, 110.0),
                  ),
                  const Text(
                    'Sincroniza tus actividades y crea alarmas para no faltar a ninguna entrega',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      height: 1.2,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 60),
                  AppleFormGroup(
                    children: [
                      AppleFormField(
                        label: 'Plataforma:',
                        labelWidth: 92,
                        controller: _platformController,
                        showClearButton: true,
                      ),
                      AppleFormField(
                        label: 'Correo asociado:',
                        labelWidth: 136,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CheckboxListTile(
                    title: const Text(
                      'Aceptar términos y condiciones',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    value: _acceptedTerms,
                    onChanged: (value) =>
                        setState(() => _acceptedTerms = value ?? false),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                    activeColor: const Color(0xFF007AFF),
                    checkboxShape: const CircleBorder(),
                    dense: true,
                  ),
                  if (_error != null)
                    Semantics(
                      liveRegion: true,
                      child: Text(
                        _error!,
                        style: const TextStyle(
                          color: Color(0xFFB3261E),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  const SizedBox(height: 44),
                  Center(
                    child: AppleButton(
                      text: 'Iniciar sincronización',
                      height: 44,
                      isFullWidth: false,
                      onPressed: _startSync,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
