class HomeServicesQuestionEntity {
  final String id;
  final String serviceId;
  final String questionName;
  final String formType;
  final List<String> options;
  final bool requiredField;
  final int order;
  final bool active;
  final String createdAt;
  final String updatedAt;

  HomeServicesQuestionEntity({
    required this.id,
    required this.serviceId,
    required this.questionName,
    required this.formType,
    required this.options,
    required this.requiredField,
    required this.order,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
  });
}