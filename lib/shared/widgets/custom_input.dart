import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class CustomInputField extends StatefulWidget {
  final String label;
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool isPassword;
  final bool isEnabled;
  final TextInputType inputType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String)? onChanged;

  const CustomInputField({
    super.key,
    required this.label,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.isEnabled = true,
    this.inputType = TextInputType.text,
    this.validator,
    this.controller,
    this.onChanged,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late bool _obscureText;

  @override
  void initState() {
    _obscureText = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.isEnabled,
      keyboardType: widget.inputType,
      obscureText: _obscureText,
      controller: widget.controller,
      validator: widget.validator,
      onChanged: widget.onChanged,

      decoration: InputDecoration(
        labelText: widget.label, // Floating label inside border
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : (widget.suffixIcon != null ? Icon(widget.suffixIcon) : null),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      ),
    );
  }
}
