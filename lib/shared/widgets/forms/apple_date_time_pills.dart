import 'package:flutter/material.dart';

class AppleDateTimePills extends StatelessWidget {
  final String label;
  final String dateText;
  final String timeText;
  final VoidCallback? onDateTap;
  final VoidCallback? onTimeTap;

  const AppleDateTimePills({
    super.key,
    required this.label,
    required this.dateText,
    required this.timeText,
    this.onDateTap,
    this.onTimeTap,
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
        Row(
          children: [
            // Date Pill
            GestureDetector(
              onTap: onDateTap,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F7), // iOS grouped background color
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Text(
                  dateText,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Time Pill
            GestureDetector(
              onTap: onTimeTap,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F7),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Text(
                  timeText,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
