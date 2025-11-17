import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/controllers/question_flow_controller.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/widgets/question_page.dart';
import 'package:yelpax/features/home_services/sub_features/service_professionals_id_zipcode/controllers/home_services_findpros_controller.dart';
import '../../../../../../shared/widgets/custom_button.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_question_entity.dart';

class QuestionFlowWidget extends StatefulWidget {
  final List<HomeServicesQuestionEntity> questions;
  const QuestionFlowWidget({super.key, required this.questions});

  @override
  State<QuestionFlowWidget> createState() => _QuestionFlowWidgetState();
}

class _QuestionFlowWidgetState extends State<QuestionFlowWidget> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuestionFlowController(questions: widget.questions),
      child: Consumer<QuestionFlowController>(
        builder: (context, controller, child) {
          // Handle flow completion
          if (controller.isQuestionFlowCompleted) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _handleFlowCompletion(context, controller);
            });
          }

          return _buildContent(context, controller);
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, QuestionFlowController controller) {
    // Handle Empty State
    if (controller.questions.isEmpty) {
      return Column(
        children: [
           AppBar(leading: BackButton()),
          const Expanded(
            child: Center(child: Text('No questions found.')),
          ),
        ],
      );
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
              ? const SizedBox.shrink()
              : IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: controller.previousPage,
                  color: Colors.white,
                ),
        ),
        const SizedBox(height: 10),
        // Progress Bar
        LinearProgressIndicator(
          value: (controller.currentPageIndex + 1) / controller.totalQuestions,
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
  }

  /// Handle flow completion - save answers and show dialog
  void _handleFlowCompletion(BuildContext context, QuestionFlowController controller) {
    // First, get and save the answers
    final answers = controller.completeFlow();
    
    final findProsController = Provider.of<HomeServicesFindprosController>(
      context,
      listen: false,
    );
    
    // Save answers to findProsController
    findProsController.saveQuestionAnswers(answers);
    print('✅ Answers saved to FindProsController: ${answers.length} answers');
    
    // Then show the quotation dialog
    _showQuotationDialog(context, controller);
  }

  /// Show dialog to send quotation to professionals
  Future<void> _showQuotationDialog(
    BuildContext context,
    QuestionFlowController controller,
  ) async {
    String selectedOption = 'fiveProfessionals';

    await showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing by tapping outside
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
                    onChanged: (val) => setState(() => selectedOption = val!),
                  ),
                  _buildOption(
                    context: context,
                    title: 'Selected Professional',
                    value: 'selectedProfessional',
                    selectedValue: selectedOption,
                    onChanged: (val) => setState(() => selectedOption = val!),
                  ),
                ],
              );
            },
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Cancel',
                    bgColor: Colors.red,
                    size: CustomButtonSize.small,
                    onPressed: () {
                      Navigator.pop(context);
                      // Optionally navigate back
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                    text: 'Confirm',
                    onPressed: () {
                      Navigator.pop(context); // close dialog first
                      controller.submitFlow(selectedOption,context);
                    },
                    size: CustomButtonSize.small,
                  ),
                ),
              ],
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
    required String selectedValue,
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