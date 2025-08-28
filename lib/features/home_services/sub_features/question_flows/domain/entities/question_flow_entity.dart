enum QuestionType { text, multipleChoice, number }

class Question {
  final String id;
  final String text;
  final QuestionType type;
  final List<Option> options;
  final bool isRequired;

  Question({
    required this.id,
    required this.text,
    required this.type,
    this.options = const [],
    this.isRequired = false,
  });
}

class Option {
  final String id;
  final String label;

  Option({required this.id, required this.label});
}

class Answer {
  final String questionId;
  final String? textValue;
  final List<String>? selectedOptionIds;
  final double? numericValue;

  Answer({
    required this.questionId,
    this.textValue,
    this.selectedOptionIds,
    this.numericValue,
  }) : assert(
         (textValue != null &&
                 selectedOptionIds == null &&
                 numericValue == null) ||
             (textValue == null &&
                 selectedOptionIds != null &&
                 numericValue == null) ||
             (textValue == null &&
                 selectedOptionIds == null &&
                 numericValue != null),
         'Answer must have exactly one type of value',
       );
}

class QuestionFlowEntity {
  final List<Question> questions;
  final int currentStep;

  QuestionFlowEntity({required this.questions, required this.currentStep});
}
