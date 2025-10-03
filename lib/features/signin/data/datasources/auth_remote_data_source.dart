import 'package:yelpax/core/network/endpoints.dart';
import '../models/signin_model.dart';

import '../../../../core/network/dio_client.dart';

class AuthRemoteDataSource {
    DioClient? dioClient;

  Future<SigninModel> signIn(String email, String password) async {
   
    final response=await dioClient!.post(
      Endpoints.login,
      data: {
        'email':email,
        'password':password
      }
      
    );

    return SigninModel.fromJson(response.data);
  }
}
