import 'package:flutter/material.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/presentation/widgets/question_flow_widget.dart';

class QuestionFlowScreen extends StatefulWidget {
  const QuestionFlowScreen({super.key});

  @override
  State<QuestionFlowScreen> createState() => _QuestionFlowScreenState();
}

class _QuestionFlowScreenState extends State<QuestionFlowScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: QuestionFlowWidget());
  }
}
