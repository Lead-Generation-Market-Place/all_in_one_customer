import 'package:dartz/dartz.dart';
import '../../../../../../core/error/exceptions/exceptions.dart';
import '../../../../../../core/error/failures/failure.dart';
import '../datasources/question_flow_remote_datasource.dart';
import '../../domain/entities/question_flow_entity.dart';
import '../../domain/repositories/question_flow_repository.dart';

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