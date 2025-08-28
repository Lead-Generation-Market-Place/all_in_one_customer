import 'package:dartz/dartz.dart';
import 'package:yelpax/core/error/exceptions/exceptions.dart';
import 'package:yelpax/core/error/failures/failure.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/data/datasources/question_flow_remote_datasource.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/domain/entities/question_flow_entity.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/domain/repositories/question_flow_repository.dart';

class QuestionFlowRepositoryimpl implements QuestionFlowRepository{
  QuestionFlowRemoteDatasource datasource;
  QuestionFlowRepositoryimpl(this.datasource);

  @override
  Future<Either<Failure, List<QuestionFlowEntity>>> getQuestion(String questionId) async{
   try{
    final response=await datasource.getQuestionFlow(questionId);
    return Right(response);
   }on ServerException catch(e){
    return Left(ServerFailure(e.message));
   }catch (ex){
    return Left(GenericFailure(ex.toString()));
   }
  }
}