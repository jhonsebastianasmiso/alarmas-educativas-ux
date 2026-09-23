import '../../styles/mobile_text_styles.dart';
import 'package:flutter/material.dart';

class MobileFlowHeader extends StatelessWidget {
  const MobileFlowHeader({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: MobileTextStyles.title,
          ),
        ),
      ),
      Align(
        alignment: Alignment.topLeft,
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
  );
}
