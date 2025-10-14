import 'package:flutter/material.dart';

class SingleChoiceWidget extends StatefulWidget {
  final List<String> options; // Specify the type for options
  final ValueChanged<String?> onSelectionChanged;

  const SingleChoiceWidget({
    Key? key,
    required this.options,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  State<SingleChoiceWidget> createState() => _SingleChoiceWidgetState();
}

class _SingleChoiceWidgetState extends State<SingleChoiceWidget> {
  String? _selectedOption; // Variable to hold the selected option

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(0),
      itemCount: widget.options.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: RadioListTile<String>(
            value: widget.options[index],
            groupValue: _selectedOption, // Manage group value
            onChanged: (val) {
              setState(() {
                _selectedOption = val; // Update selected option
              });
              widget.onSelectionChanged(val); // Notify parent
            },
            title: Text(
              widget.options[index],
              style: TextStyle(
                fontSize: 16,
                fontWeight: _selectedOption == widget.options[index]
                    ? FontWeight.w600
                    : FontWeight.normal,
                color: _selectedOption == widget.options[index]
                    ? Theme.of(context).colorScheme.primary
                    : Colors.black87,
              ),
            ),
            activeColor: Theme.of(context).colorScheme.primary,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
        );
      },
    );
  }
}