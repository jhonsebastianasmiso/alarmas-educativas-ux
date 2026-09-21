import 'package:flutter/material.dart';

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mobile Login')),
      body: const Center(
        child: Text(
          'Login Mobile (Próximamente)',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
