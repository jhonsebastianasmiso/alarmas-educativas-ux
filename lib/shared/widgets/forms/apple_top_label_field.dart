import 'package:flutter/material.dart';

class AppleTopLabelField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final String? placeholder;
  final bool obscureText;
  final TextInputType keyboardType;
  final int maxLines;

  const AppleTopLabelField({
    super.key,
    required this.label,
    this.controller,
    this.placeholder,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
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
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF2F2F7),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: maxLines > 1 ? TextInputType.multiline : keyboardType,
            textInputAction: maxLines > 1 ? TextInputAction.newline : null,
            maxLines: maxLines,
            style: const TextStyle(fontSize: 16, color: Colors.black),
            decoration: InputDecoration(
              hintText: placeholder,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            ),
          ),
        ),
      ],
    );
  }
}
