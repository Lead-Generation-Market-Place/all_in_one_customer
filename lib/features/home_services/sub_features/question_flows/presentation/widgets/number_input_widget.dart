// features/home_services/sub_features/question_flows/presentation/widgets/question_types/number_input_widget.dart
import 'package:flutter/material.dart';

class NumberInputWidget extends StatelessWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;

  const NumberInputWidget({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: TextEditingController(text: initialValue),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: "Enter number",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onChanged: onChanged,
      ),
    );
  }
}