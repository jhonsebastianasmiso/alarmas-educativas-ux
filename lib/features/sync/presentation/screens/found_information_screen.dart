import 'package:flutter/material.dart';
import '../../../../shared/widgets/layouts/web_layout.dart';

class FoundInformationScreen extends StatelessWidget {
  const FoundInformationScreen({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(child: WebLayout(child: Center(child: Text('Información encontrada')))),
  );
}
