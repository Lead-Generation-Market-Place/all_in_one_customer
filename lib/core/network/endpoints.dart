//all endpoints will be rigestered here
abstract class Endpoints {
  //static const String baseUrl = 'https://servicyee-backend.onrender.com/api/v1';  //real server
  static const String baseUrl='http://10.0.2.2:4000/api/v1';   //test server

  // Auth endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';

  // User endpoints
  static const String getUserProfile = '/users/profile';
  static const String updateUserProfile = '/users/profile';
  static const String changePassword = '/users/change-password';

  // Services endpoints
  static const String getServices = '/services';
  // static const String getProductDetail = '/products/{id}';
  // static const String createProduct = '/products';
  // static const String updateProduct = '/products/{id}';
  // static const String deleteProduct = '/products/{id}';

  // Order endpoints
  static const String getOrders = '/orders';
  static const String createOrder = '/orders';
  static const String getOrderDetail = '/orders/{id}';

  //promotions endpoints
  static const String promotions='/promotions';

  //fetching professionals endpoints
  static const String findpros='/findpros';


  // Helper method to replace path parameters
  static String replacePathParameters(String path, Map<String, dynamic> params) {
    String result = path;
    params.forEach((key, value) {
      result = result.replaceAll('{$key}', value.toString());
    });
    return result;
  }
}