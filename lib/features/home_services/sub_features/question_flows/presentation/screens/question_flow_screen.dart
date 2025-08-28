import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/presentation/controllers/question_flow_controller.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/question_flow_di.dart';

class QuestionFlowScreen extends StatefulWidget {
  const QuestionFlowScreen({super.key});

  @override
  State<QuestionFlowScreen> createState() => _QuestionFlowScreenState();
}

class _QuestionFlowScreenState extends State<QuestionFlowScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => questionFlowDi(),
      child: Scaffold(body: Center(child: Text('Hello'))),
    );
  }
}
