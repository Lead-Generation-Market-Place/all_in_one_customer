import 'package:flutter/material.dart';

class MultipleChoiceWidget extends StatelessWidget {
  final List<String> choices;
  final List<String> selectedChoiceIds;
  final ValueChanged<List<String>> onSelectionChanged;

  const MultipleChoiceWidget({
    super.key,
    required this.choices,
    required this.selectedChoiceIds,
    required this.onSelectionChanged,
  });

  void _onChanged(String option) {
    final newSelectedIds = List<String>.from(selectedChoiceIds);
    if (newSelectedIds.contains(option)) {
      newSelectedIds.remove(option);
    } else {
      newSelectedIds.add(option);
    }
    onSelectionChanged(newSelectedIds);
  }

  @override
 Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: choices.map((option) {
        final isSelected = selectedChoiceIds.contains(option);
        return FilterChip(
          label: Text(
            option,
            style: TextStyle(
              fontSize: 14,
              color: isSelected
                  ? Colors.white
                  : Theme.of(context).colorScheme.onSurface,
            ),
          ),
          selected: isSelected,
          selectedColor: Theme.of(context).colorScheme.primary,
          checkmarkColor: Colors.white,
          showCheckmark: true,
          onSelected: (selected) => _onChanged(option),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).dividerColor,
            ),
          ),
        );
      }).toList(),
    );
  }
}