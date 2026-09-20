import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../../shared/widgets/layouts/web_layout.dart';
import '../../../../shared/widgets/buttons/apple_button.dart';

class SuccessMessageScreen extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final String buttonText;
  final VoidCallback onPressed;

  const SuccessMessageScreen({
    super.key,
    required this.title,
    required this.message,
    required this.icon,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: WebLayout(
          maxWidth: 600,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(flex: 2),
                
                // Success Icon
                Icon(
                  icon,
                  size: 100,
                  color: const Color(0xFF007AFF), // Apple iOS Blue
                ),
                const SizedBox(height: 32),
                
                // Title
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Message
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
                
                const Spacer(flex: 3),
                
                // Action Button
                Align(
                  alignment: Alignment.center,
                  child: AppleButton(
                    text: buttonText,
                    onPressed: onPressed,
                    isFullWidth: false,
                  ),
                ),
                
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
