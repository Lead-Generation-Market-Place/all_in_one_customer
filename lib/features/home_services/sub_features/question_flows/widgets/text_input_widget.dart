import 'package:flutter/material.dart';

class TextInputWidget extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;

  const TextInputWidget({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(TextInputWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update controller text if initialValue changes from outside
    if (oldWidget.initialValue != widget.initialValue) {
      _controller.text = widget.initialValue;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _controller,
        keyboardType: TextInputType.text,
        maxLines: 3,
        decoration: InputDecoration(
          labelText: "Your answer",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}