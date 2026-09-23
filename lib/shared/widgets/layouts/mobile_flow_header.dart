import 'package:flutter/material.dart';

/// Mobile flow header that also accommodates multiline titles and large text.
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
            style: const TextStyle(
              fontSize: 30,
              height: 1.2,
              fontWeight: FontWeight.w700,
              color: Color(0xFF007AFF),
            ),
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
