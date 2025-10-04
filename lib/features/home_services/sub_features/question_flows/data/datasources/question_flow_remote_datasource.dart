import '../../../../../../core/error/exceptions/exceptions.dart';
import '../models/question_flow_model.dart';
import '../../domain/entities/question_flow_entity.dart';

abstract class QuestionFlowRemoteDatasource {
  Future<List<QuestionFlowModel>> getQuestionFlow(String flowId);
  Future<Question> getQuestionById(String questionId);
}

class QuestionFlowRemoteDatasourceImpl implements QuestionFlowRemoteDatasource {
  static final List<Question> sampleQuestions = [
    Question(
      id: '1',
      text: 'What is your name?',
      type: QuestionType.text,
      isRequired: true,
    ),
    Question(
      id: '2',
      text: 'How old are you?',
      type: QuestionType.number,
      isRequired: true,
    ),
    Question(
      id: '3',
      text: 'What is your favorite color?',
      type: QuestionType.multipleChoice,
      isRequired: false,
      options: [
        Option(id: '3a', label: 'Red'),
        Option(id: '3b', label: 'Blue'),
        Option(id: '3c', label: 'Green'),
        Option(id: '3d', label: 'Yellow'),
      ],
    ),
    Question(
      id: '4',
      text: 'Select your hobbies',
      type: QuestionType.multipleChoice,
      isRequired: true,
      options: [
        Option(id: '4a', label: 'Reading'),
        Option(id: '4b', label: 'Sports'),
        Option(id: '4c', label: 'Music'),
        Option(id: '4d', label: 'Traveling'),
        Option(id: '4e', label: 'Cooking'),
      ],
    ),
    Question(
      id: '5',
      text: 'Tell us about yourself',
      type: QuestionType.text,
      isRequired: false,
    ),
    Question(
      id:'6',
      text: 'What is your gender',
      type: QuestionType.radio,
      isRequired: true,
      options: [
        Option(id: 'm', label: 'Male'),
        Option(id: 'f', label: 'Female'),
      ]
    )
  ];

  @override
  Future<Question> getQuestionById(String id) async {
    try {
      final question = sampleQuestions.firstWhere(
        (element) => element.id == id,
        orElse: () => throw NotFoundException('Question with id $id not found'),
      );
      return question;
    } catch (e) {
      if (e is NotFoundException) {
        throw e;
      }
      throw ServerException('Failed to fetch question: ${e.toString()}');
    }
  }

  @override
  Future<List<QuestionFlowModel>> getQuestionFlow(String flowId) async {
    try {
      await Future.delayed(Duration(seconds: 1));
      
      // Return a list of QuestionFlowModel (to match List<QuestionFlowEntity> expectation)
      return [
        QuestionFlowModel(questions: sampleQuestions, currentStep: 0),
        // You can add more flows here if needed for testing
      ];
    } catch (e) {
      throw ServerException('Failed to fetch question flow: ${e.toString()}');
    }
  }
}