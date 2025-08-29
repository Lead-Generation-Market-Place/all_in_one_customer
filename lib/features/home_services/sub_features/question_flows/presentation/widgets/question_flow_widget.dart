// features/home_services/sub_features/question_flows/presentation/widgets/question_flow_widget.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/presentation/controllers/question_flow_controller.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/presentation/widgets/question_page.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/question_flow_di.dart'; // We'll create this next

class QuestionFlowWidget extends StatelessWidget {
  const QuestionFlowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => questionFlowDi(),
      child:  Consumer<QuestionFlowController>(
          builder: (context, controller, child) {
            // Handle Loading State
            if (controller.isLoadingQuestion) {
              return const Center(child: CircularProgressIndicator());
            }

            // Handle Error State
            if (controller.errorMessage.isNotEmpty) {
              return Center(child: Text('Error: ${controller.errorMessage}'));
            }

            // Handle Empty State
            if (controller.questions.isEmpty) {
              return const Center(child: Text('No questions found.'));
            }

            // Show the Flow
            return Column(
              children: [
                // App Bar with Progress
                AppBar(
                  title: Text(
                      'Question ${controller.currentPageIndex + 1} of ${controller.totalQuestions}'),
                  leading: controller.isFirstQuestion
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: controller.previousPage,
                          color: Colors.white,
                        ),
                ),
                SizedBox(height:10),
                // Progress Bar
                LinearProgressIndicator(
                  value: (controller.currentPageIndex + 1) /
                      controller.totalQuestions,
                ),
                // The PageView for questions
                Expanded(
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: controller.pageController,
                    itemCount: controller.totalQuestions,
                    itemBuilder: (context, index) {
                      final question =
                          controller.questions[0].questions[index];
                      return QuestionPage(
                          question: question, questionIndex: index);
                    },
                  ),
                ),
              ],
            );
          },
        ),
    );
  }
}