import 'package:dio/dio.dart';
import 'package:yelpax/features/signin/data/models/signin_model.dart';

import '../../../../core/network/dio_client.dart';

class AuthRemoteDataSource {
  final Dio dio = DioClient().dio;

  Future<SigninModel> signIn(String email, String password) async {
    final response = await dio.post(
      '/login',
      data: {'email': email, 'password': password},
    );

    return SigninModel.fromJson(response.data);
  }
}
