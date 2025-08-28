import 'package:yelpax/features/home_services/sub_features/question_flows/data/datasources/question_flow_remote_datasource.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/data/repositories/question_flow_repositoryImpl.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/domain/usecases/question_flow_usecase.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/presentation/controllers/question_flow_controller.dart';

QuestionFlowController questionFlowDi(){
  QuestionFlowRemoteDatasourceImpl datasource=QuestionFlowRemoteDatasourceImpl();
  QuestionFlowRepositoryimpl repo=QuestionFlowRepositoryimpl(datasource);
  QuestionFlowUsecase usecase=QuestionFlowUsecase(repo);
  return QuestionFlowController(usecase);
}