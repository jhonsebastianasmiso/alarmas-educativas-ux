import 'package:flutter/material.dart';
import 'apple_menu_dialog.dart';

class AppleMainHeader extends StatelessWidget {
  final String? title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Widget? rightActionWidget;
  final String currentScreen;

  const AppleMainHeader({
    super.key,
    this.title,
    this.showBackButton = false,
    this.onBackPressed,
    this.rightActionWidget,
    this.currentScreen = '',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => showAppleMenu(context, currentScreen: currentScreen),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedIcon(
                      icon: AnimatedIcons.menu_close,
                      progress: AlwaysStoppedAnimation(0.0),
                      size: 32,
                      color: Colors.black,
                    ),
                    SizedBox(width: 8),
                    Text(
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
            ),
          ),

          if (title != null)
            Text(
              title!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: Color(0xFF007AFF),
              ),
            ),

          Align(
            alignment: Alignment.centerRight,
            child: rightActionWidget ??
                (showBackButton
                    ? GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: onBackPressed ??
                            () {
                              if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              }
                            },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            size: 32,
                            color: Color(0xFF007AFF),
                          ),
                        ),
                      )
                    : const SizedBox.shrink()),
          ),
        ],
      ),
    );
  }
}
