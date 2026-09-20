import 'package:flutter/material.dart';

class AppleHeader extends StatelessWidget {
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final String? title;

  const AppleHeader({
    super.key,
    this.showBackButton = true,
    this.onBackPressed,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (title != null)
            Text(
              title!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: Color(0xFF007AFF), // Apple iOS Blue
              ),
            ),
          if (showBackButton)
            Align(
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
            ),
        ],
      ),
    );
  }
}
