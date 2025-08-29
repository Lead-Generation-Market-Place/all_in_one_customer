// features/home_services/sub_features/question_flows/presentation/widgets/question_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/domain/entities/question_flow_entity.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/presentation/controllers/question_flow_controller.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/presentation/widgets/multiple_choice_widget.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/presentation/widgets/number_input_widget.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/presentation/widgets/single_choice_widget.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/presentation/widgets/text_input_widget.dart';
import 'package:yelpax/shared/widgets/custom_button.dart';

class QuestionPage extends StatelessWidget {
  final Question question;
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
          Text(question.text, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 24),
          // The appropriate input widget
          _buildQuestionOptions(
            context,
            question.type,
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
    QuestionType type,
    List<Option> options,
    dynamic currentAnswer,
    Function(dynamic) onAnswerSubmitted,
  ) {
    switch (type) {
      case QuestionType.multipleChoice:
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
      case QuestionType.radio:
        Option? selectedOption;
        if (currentAnswer is Option) {
          selectedOption = currentAnswer;
        }
        return SingleChoiceWidget(
          choices: options,
          selectedChoiceId: selectedOption?.id,
          onSelectionChanged: onAnswerSubmitted,
        );
      case QuestionType.number:
        return NumberInputWidget(
          initialValue: currentAnswer as String? ?? '',
          onChanged: onAnswerSubmitted,
        );
      case QuestionType.text:
        return TextInputWidget(
          initialValue: currentAnswer as String? ?? '',
          onChanged: onAnswerSubmitted,
        );
      default:
        return Text('Question type "$type" not implemented');
    }
  }
}
