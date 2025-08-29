import 'package:dartz/dartz.dart';
import 'package:yelpax/core/error/failures/failure.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/domain/entities/question_flow_entity.dart';

abstract class QuestionFlowRepository {
  Future<Either<Failure, List<QuestionFlowEntity>>> getQuestion(
    String questionId,
  );
}
