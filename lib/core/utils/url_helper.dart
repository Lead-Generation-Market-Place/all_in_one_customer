// core/utils/url_helper.dart
class UrlHelper {
  static String fixImageUrl(String url) {
    if (url.contains('localhost') || url.contains('127.0.0.1')) {
      // Replace localhost with your actual domain
      return url.replaceAll(
        'http://localhost:4000',
        'https://servicyee-backend.onrender.com',
      );
    }
    return url;
  }

  static String? fixImageUrlNullable(String? url) {
    if (url == null) return null;
    return fixImageUrl(url);
  }
}