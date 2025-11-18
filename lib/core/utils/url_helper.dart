import 'package:yelpax/core/network/endpoints.dart';

class UrlHelper {
  static String fixImageUrl(String imageUrl) {
    if (imageUrl.isEmpty) return '';
    
    // If it's already a full URL, return as is
    if (imageUrl.startsWith('http')) {
      return imageUrl;
    }
    
    // If it's a relative path, prepend the base URL
    if (imageUrl.startsWith('uploads/') || imageUrl.startsWith('/uploads/')) {
      // Remove leading slash if present
      final cleanPath = imageUrl.startsWith('/') ? imageUrl.substring(1) : imageUrl;
      return '${Endpoints.baseUrl}/$cleanPath';
    }
    
    // For any other relative paths
    return '${Endpoints.baseUrl}/$imageUrl';
  }
}