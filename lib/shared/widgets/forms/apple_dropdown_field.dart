import 'package:flutter/material.dart';

class AppleDropdownField extends StatelessWidget {
  final String label;
  final String valueText;
  final Color? indicatorColor;
  final VoidCallback? onTap;

  const AppleDropdownField({
    super.key,
    required this.label,
    required this.valueText,
    this.indicatorColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F7),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Row(
              children: [
                if (indicatorColor != null) ...[
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: indicatorColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    valueText,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                    textAlign: indicatorColor != null ? TextAlign.center : TextAlign.left,
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
