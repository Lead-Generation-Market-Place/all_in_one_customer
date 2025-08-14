import 'package:flutter/material.dart';

class CustomInput extends StatefulWidget {
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  CustomInput({
    super.key,
    required this.hint,
    required this.icon,
    required this.controller,
    this.onChanged,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
        color: Theme.of(context).primaryColor,
        letterSpacing: 1.2,
      ),

      onChanged: widget.onChanged,

      decoration: InputDecoration(
        prefixIcon: Icon(widget.icon, size: 20),
        hintText: widget.hint,
      ),
    );
  }
}
