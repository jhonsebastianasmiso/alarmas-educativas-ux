import 'package:flutter/material.dart';
import '../../../../shared/widgets/layouts/web_layout.dart';

class MobileConnectScreen extends StatelessWidget {
  const MobileConnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: WebLayout(child: Center(child: Text('Conectar'))),
      ),
    );
  }
}
