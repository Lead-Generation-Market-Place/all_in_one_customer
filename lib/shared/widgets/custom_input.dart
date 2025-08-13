import 'package:flutter/material.dart';

class CustomInput extends StatefulWidget {
  String hint;
  IconData icon;
  TextEditingController controller;
  CustomInput({
    super.key,
    required this.hint,
    required this.icon,
    required this.controller,
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
      decoration: InputDecoration(
        prefixIcon: Icon(widget.icon, size: 20),
        hintText: widget.hint,
      ),
    );
  }
}
