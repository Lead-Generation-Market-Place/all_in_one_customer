import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/presentation/controllers/question_flow_controller.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/presentation/widgets/question_flow_widget.dart';
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
      child: Scaffold(
      body: questionFlowBody()),
    );
  }
}

class questionFlowBody extends StatefulWidget {
  const questionFlowBody({super.key});

  @override
  State<questionFlowBody> createState() => _questionFlowBodyState();
}

class _questionFlowBodyState extends State<questionFlowBody> {
  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionFlowController>(
      builder: (context, value, child) {

        if(value.isLoadingQuestion){
          return Center(child: CircularProgressIndicator.adaptive());
        }

        if(value.errorMessage.isNotEmpty && value.errorMessage==''){
          return Text('Error Occured ${value.errorMessage}');
        }
        
        return QuestionFlowWidget();
      },
    );
  }
}
