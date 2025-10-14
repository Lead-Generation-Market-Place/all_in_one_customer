// features/home_services/sub_features/question_flows/presentation/widgets/question_types/multiple_choice_widget.dart

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

  void _onChanged(bool? selected, String option) {
    final newSelectedIds = List<String>.from(selectedChoiceIds);
    if (selected == true) {
      if (!newSelectedIds.contains(option)) {
        newSelectedIds.add(option);
      }
    } else {
      newSelectedIds.remove(option);
    }
    onSelectionChanged(newSelectedIds);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(0),
      itemCount: choices.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final option = choices[index];
        final isSelected = selectedChoiceIds.contains(option);

        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: CheckboxListTile(
            value: isSelected,
            onChanged: (val) => _onChanged(val, option),
            title: Text(
              option,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.black87,
              ),
            ),
            controlAffinity: ListTileControlAffinity.trailing,
            activeColor: Theme.of(context).colorScheme.primary,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
        );
      },
    );
  }
}