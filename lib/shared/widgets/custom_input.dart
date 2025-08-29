import 'package:flutter/material.dart';

class CustomInput extends StatefulWidget {
  final FormFieldValidator? validator;
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final suffixIcon;

  CustomInput({
    this.validator,

    required this.hint,
    required this.icon,
    required this.controller,
    this.onChanged,
    this.suffixIcon,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
        color: Theme.of(context).primaryColor,
        letterSpacing: 1.2,
      ),

      onChanged: widget.onChanged,
      controller: widget.controller,

      decoration: InputDecoration(
        prefixIcon: Icon(widget.icon, size: 20),
        hintText: widget.hint,
        suffixIcon: widget.suffixIcon,
      ),
    );
  }
}
