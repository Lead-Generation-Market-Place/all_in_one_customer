import 'package:flutter/material.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_question_entity.dart';
import '../widgets/question_flow_widget.dart';

class QuestionFlowScreen extends StatefulWidget {
 final List<HomeServicesQuestionEntity> entities;
   QuestionFlowScreen({super.key,required this.entities});

  @override
  State<QuestionFlowScreen> createState() => _QuestionFlowScreenState();
}

class _QuestionFlowScreenState extends State<QuestionFlowScreen> {

  @override
  Widget build(BuildContext context) {
   
  return Scaffold(body: QuestionFlowWidget(questions: widget.entities));
 
  }

 
 
}
