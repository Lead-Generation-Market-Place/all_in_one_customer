import 'package:flutter/material.dart';

class DateInputWidget extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;

  const DateInputWidget({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<DateInputWidget> createState() => _DateInputWidgetState();
}

class _DateInputWidgetState extends State<DateInputWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(_controller.text) ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      String formatted = picked.toIso8601String().split('T').first;
      _controller.text = formatted;
      widget.onChanged(formatted);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: 'Select date',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => _pickDate(context),
          ),
        ),
        onTap: () => _pickDate(context),
      ),
    );
  }
}
