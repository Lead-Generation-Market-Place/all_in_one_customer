import 'package:dio/dio.dart';
import 'package:yelpax/features/signin/data/models/signin_model.dart';

import '../../../../core/network/api_service.dart';

class AuthRemoteDataSource {
  final APIService _service = APIService.instance;

  Future<SigninModel> signIn(String email, String password) async {
    final Response response = await _service.request(
      'login',
      DioMethod.post,
      contentType: 'application/json',
      param: {'email': email, 'password': password},
    );

    return SigninModel.fromJson(response.data);
  }
}
