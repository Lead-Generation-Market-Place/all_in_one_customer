import 'data/datasources/question_flow_remote_datasource.dart';
import 'data/repositories/question_flow_repositoryImpl.dart';
import 'domain/usecases/question_flow_usecase.dart';
import 'presentation/controllers/question_flow_controller.dart';

QuestionFlowController questionFlowDi(){
  QuestionFlowRemoteDatasourceImpl datasource=QuestionFlowRemoteDatasourceImpl();
  QuestionFlowRepositoryimpl repo=QuestionFlowRepositoryimpl(datasource);
  QuestionFlowUsecase usecase=QuestionFlowUsecase(repo);
  return QuestionFlowController(usecase);
}