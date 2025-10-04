import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures/failure.dart';
import '../entities/question_flow_entity.dart';

abstract class QuestionFlowRepository {
  Future<Either<Failure, List<QuestionFlowEntity>>> getQuestion(
    String questionId,
  );
}
