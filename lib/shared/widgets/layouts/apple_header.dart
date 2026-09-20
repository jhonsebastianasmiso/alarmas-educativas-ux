import 'package:flutter/material.dart';

class AppleHeader extends StatelessWidget {
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  const AppleHeader({
    super.key,
    this.showBackButton = true,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (!showBackButton) {
      return const SizedBox(height: 40); // Placeholder to keep spacing if no button
    }

    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: onBackPressed ??
            () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
        child: const Icon(
          Icons.arrow_back_ios_new,
          size: 40,
          color: Color(0xFF007AFF), // Apple iOS Blue
        ),
      ),
    );
  }
}
