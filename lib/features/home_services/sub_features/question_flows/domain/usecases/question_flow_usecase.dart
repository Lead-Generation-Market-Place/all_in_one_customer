import 'package:dartz/dartz.dart';
import 'package:yelpax/core/error/failures/failure.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/domain/entities/question_flow_entity.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/domain/repositories/question_flow_repository.dart';

class QuestionFlowUsecase {
  final QuestionFlowRepository repo;
  QuestionFlowUsecase(this.repo);
  Future<Either<Failure, List<QuestionFlowEntity>>> call(String questionId) {
    return repo.getQuestion(questionId);
  }
}
