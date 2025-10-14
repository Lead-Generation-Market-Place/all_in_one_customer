// features/home_services/sub_features/question_flows/presentation/widgets/question_page.dart
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_question_entity.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/widgets/checkbox_input_widget.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/widgets/date_input_widget.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/widgets/multiple_choice_widget.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/widgets/number_input_widget.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/widgets/single_choice_widget.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/widgets/text_input_widget.dart';
import 'package:yelpax/shared/widgets/custom_button.dart';

import '../controllers/question_flow_controller.dart';

class QuestionPage extends StatelessWidget {
  final HomeServicesQuestionEntity question;
  final int questionIndex;

  const QuestionPage({
    super.key,
    required this.question,
    required this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<QuestionFlowController>(context);
    final currentAnswer = controller.getAnswerForQuestion(questionIndex);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question Text
          Text(question.questionName, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 24),
          // The appropriate input widget
          _buildQuestionOptions(
            context,
            question.formType,
            question.options,
            currentAnswer,
            (answer) => controller.submitAnswer(questionIndex, answer),
          ),
          const Spacer(),
          // Next/Finish Button
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              onPressed: () => controller.nextPage(),
              text: controller.isLastQuestion ? 'Finish' : 'Next',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionOptions(
    BuildContext context,
    String type,
    List<String> options,
    dynamic currentAnswer,
    Function(dynamic) onAnswerSubmitted,
  ) {
    switch (type) {
      case "select":
        final controller = Provider.of<QuestionFlowController>(
          context,
          listen: false,
        );
        final selectedOptionIds = controller.getSelectedOptionIdsForQuestion(
          questionIndex,
        );

        return MultipleChoiceWidget(
          choices: options,
          selectedChoiceIds: selectedOptionIds, // Now passing List<String>
          onSelectionChanged: onAnswerSubmitted,
        );
      case "radio":
        Option? selectedOption;
        if (currentAnswer is Option) {
          selectedOption = currentAnswer;
        }
        return SingleChoiceWidget(
          choices: options,
          selectedChoiceId: "dummyid",
          onSelectionChanged: onAnswerSubmitted,
        );
      case "number":
        return NumberInputWidget(
          initialValue: currentAnswer as String? ?? '',
          onChanged: onAnswerSubmitted,
        );
      case "text":
        return TextInputWidget(
          initialValue: currentAnswer as String? ?? '',
          onChanged: onAnswerSubmitted,
        );
      case "checkbox":
        return CheckBoxInputWidget(
          initialValue: false,
          onChanged: onAnswerSubmitted,
        );
      case "date":
        return DateInputWidget(
          initialValue: currentAnswer as String? ?? '',
          onChanged: onAnswerSubmitted,
        );
      default:
        return Text('Question type "$type" not implemented');
    }
  }
}
