import 'package:flutter/material.dart';

/// Checkbox input for a single boolean value (checked/unchecked)
class CheckBoxInputWidget extends StatelessWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const CheckBoxInputWidget({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Checkbox(
            value: initialValue,
            onChanged: (val) => onChanged(val ?? false),
          ),
          const SizedBox(width: 8),
          const Text('Check if applicable'),
        ],
      ),
    );
  }
}
