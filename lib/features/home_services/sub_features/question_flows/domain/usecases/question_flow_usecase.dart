import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures/failure.dart';
import '../entities/question_flow_entity.dart';
import '../repositories/question_flow_repository.dart';

class QuestionFlowUsecase {
  final QuestionFlowRepository repo;
  QuestionFlowUsecase(this.repo);
  Future<Either<Failure, List<QuestionFlowEntity>>> call(String questionId) {
    return repo.getQuestion(questionId);
  }
}
