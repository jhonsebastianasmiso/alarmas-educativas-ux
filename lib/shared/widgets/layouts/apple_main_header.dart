import 'package:flutter/material.dart';

class AppleMainHeader extends StatelessWidget {
  final String? title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Widget? rightActionWidget;

  const AppleMainHeader({
    super.key,
    this.title,
    this.showBackButton = false,
    this.onBackPressed,
    this.rightActionWidget,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Left: Hamburger Menu + "Menú"
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.menu,
                  size: 32,
                  color: Colors.black,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Menú',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),

          // Center: Title (if any)
          if (title != null)
            Text(
              title!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: Color(0xFF007AFF), // Apple iOS Blue
              ),
            ),

          // Right: Action Widget or Back Button
          Align(
            alignment: Alignment.centerRight,
            child: rightActionWidget ??
                (showBackButton
                    ? GestureDetector(
                        onTap: onBackPressed ??
                            () {
                              if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              }
                            },
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 36,
                          color: Color(0xFF007AFF), // Apple iOS Blue
                        ),
                      )
                    : const SizedBox.shrink()),
          ),
        ],
      ),
    );
  }
}
