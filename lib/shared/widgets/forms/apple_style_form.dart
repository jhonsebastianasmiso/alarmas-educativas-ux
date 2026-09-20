import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppleFormGroup extends StatelessWidget {
  final List<Widget> children;

  const AppleFormGroup({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F7), // iOS grouped background color
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: children.asMap().entries.map((entry) {
          int idx = entry.key;
          Widget child = entry.value;
          bool isLast = idx == children.length - 1;

          return Column(
            children: [
              child,
              if (!isLast)
                Container(
                  margin: const EdgeInsets.only(left: 16.0),
                  height: 0.5,
                  color: Colors.grey.withOpacity(0.3),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class AppleFormField extends StatefulWidget {
  final String label;
  final String? placeholder;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final bool showClearButton;
  final ValueChanged<String>? onChanged;
  final double labelWidth;

  const AppleFormField({
    super.key,
    required this.label,
    this.placeholder,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.showClearButton = false,
    this.onChanged,
    this.labelWidth = 100.0,
  });

  @override
  State<AppleFormField> createState() => _AppleFormFieldState();
}

class _AppleFormFieldState extends State<AppleFormField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onTextChanged() {
    if (widget.showClearButton) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: widget.labelWidth, // Dynamic width for labels
            child: Text(
              widget.label,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: _controller,
              obscureText: widget.obscureText,
              keyboardType: widget.keyboardType,
              onChanged: widget.onChanged,
              style: const TextStyle(fontSize: 16, color: Colors.black),
              decoration: InputDecoration(
                hintText: widget.placeholder,
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
              ),
            ),
          ),
          if (widget.showClearButton && _controller.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                _controller.clear();
                if (widget.onChanged != null) {
                  widget.onChanged!('');
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(
                  CupertinoIcons.clear_thick_circled,
                  color: Colors.grey.shade400,
                  size: 18,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
