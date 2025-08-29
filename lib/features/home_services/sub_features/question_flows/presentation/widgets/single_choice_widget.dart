// features/home_services/sub_features/question_flows/presentation/widgets/question_types/single_choice_widget.dart
import 'package:flutter/material.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/domain/entities/question_flow_entity.dart';

class SingleChoiceWidget extends StatelessWidget {
  final List<Option> choices;
  final String? selectedChoiceId;
  final ValueChanged<Option> onSelectionChanged;

  const SingleChoiceWidget({
    super.key,
    required this.choices,
    required this.selectedChoiceId,
    required this.onSelectionChanged,
  });

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
        final isSelected = option.id == selectedChoiceId;

        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: RadioListTile<String>(
            value: option.id,
            groupValue: selectedChoiceId,
            onChanged: (val) => onSelectionChanged(option),
            title: Text(
              option.label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected
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