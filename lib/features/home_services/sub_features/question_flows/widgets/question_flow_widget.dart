// features/home_services/sub_features/question_flows/presentation/widgets/question_flow_widget.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/controllers/question_flow_controller.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/widgets/question_page.dart';

import '../../../../../../shared/widgets/custom_button.dart';

import 'package:yelpax/features/home_services/domain/entities/home_services_question_entity.dart';

class QuestionFlowWidget extends StatelessWidget {
  final List<HomeServicesQuestionEntity> questions;
  const QuestionFlowWidget({super.key, required this.questions});
  

  @override
  Widget build(BuildContext context) {
    questions.forEach((element) => print(element.formType),);
    return ChangeNotifierProvider(
      create: (context) => QuestionFlowController(questions: questions),
      child: Consumer<QuestionFlowController>(
        builder: (context, controller, child) {
          // Handle Empty State
          if (controller.questions.isEmpty) {
            return const Center(child: Text('No questions found.'));
          }
          //Handle Question Flow completed and send to professional
          if (controller.isQuestionFlowCompleted) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              sendQuotationToProfessionals(
                context,
                'Send Quotation',
                controller,
              );
            });
          }
          // Show the Flow
          return Column(
            children: [
              // App Bar with Progress
              AppBar(
                title: Text(
                  'Question ${controller.currentPageIndex + 1} of ${controller.totalQuestions}',
                ),
                leading: controller.isFirstQuestion
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: controller.previousPage,
                        color: Colors.white,
                      ),
              ),
              SizedBox(height: 10),
              // Progress Bar
              LinearProgressIndicator(
                value:
                    (controller.currentPageIndex + 1) /
                    controller.totalQuestions,
              ),
              // The PageView for questions
              Expanded(
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller.pageController,
                  itemCount: controller.totalQuestions,
                  itemBuilder: (context, index) {
                    final question = controller.questions[index];
                    return QuestionPage(
                      question: question,
                      questionIndex: index,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  //a widget of a dialog to show send a quotation
Future<void> sendQuotationToProfessionals(
  BuildContext context,
  String title,
  QuestionFlowController controller,
) async {
  String? selectedOption = 'fiveProfessionals';

  await showDialog(
    context: context,
    builder: (context) {
      final textTheme = Theme.of(context).textTheme;

      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Send Quotation', style: textTheme.titleSmall),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.close),
            ),
          ],
        ),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'For faster responses and more accurate pricing, '
                  'we recommend sending your quotation request to the top 5 '
                  'recommended professionals, including your selected professional.',
                  style: textTheme.bodySmall?.copyWith(color: Colors.red),
                ),
                const Divider(),
                _buildOption(
                  context: context,
                  title: 'Request To Top 5 Pros',
                  value: 'fiveProfessionals',
                  selectedValue: selectedOption,
                  onChanged: (val) => setState(() => selectedOption = val),
                ),
                _buildOption(
                  context: context,
                  title: 'Selected Professional',
                  value: 'selectedProfessional',
                  selectedValue: selectedOption,
                  onChanged: (val) => setState(() => selectedOption = val),
                ),
              ],
            );
          },
        ),
        actions: [
          CustomButton(
            text: 'Confirm',
            onPressed: () {
              Navigator.pop(context); // close dialog first
              controller.submitFlow(selectedOption??'fiveProfessionals');
            },
            size: CustomButtonSize.small,
          ),
          const SizedBox(height: 10),
          CustomButton(
            text: 'Cancel',
            bgColor: Colors.red,
            size: CustomButtonSize.small,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      );
    },
  );
}

/// Reusable radio list option builder
Widget _buildOption({
  required BuildContext context,
  required String title,
  required String value,
  required String? selectedValue,
  required ValueChanged<String?> onChanged,
}) {
  final textTheme = Theme.of(context).textTheme;
  return RadioListTile<String>(
    value: value,
    groupValue: selectedValue,
    onChanged: onChanged,
    title: Text(title, style: textTheme.bodySmall),
  );
}

}
