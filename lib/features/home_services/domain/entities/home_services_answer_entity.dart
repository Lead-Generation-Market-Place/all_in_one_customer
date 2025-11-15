class HomeServicesAnswerEntity {
    final String questionId;
  final String answer;
  final bool isFallback;

  HomeServicesAnswerEntity({
    required this.questionId,
    required this.answer,
    this.isFallback = false,
  });
}