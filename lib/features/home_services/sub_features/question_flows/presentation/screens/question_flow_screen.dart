import 'package:flutter/material.dart';
import '../widgets/question_flow_widget.dart';

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
