import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:yelpax/core/injection_container.dart';
import 'package:yelpax/core/network/dio_client.dart';
import 'package:yelpax/features/home_services/data/datasources/home_services_remote_data_source.dart';

class MockClient extends Mock implements DioClient {}

void main() {
  test(
    "Testing the data source if the response is coming and valid or not",
    () async {
      HomeServicesRemoteDataSourceImpl dataSource =
          HomeServicesRemoteDataSourceImpl(
            dioClient: DioClient(dio: getIt(), logger: getIt()),
          );
      var data = await dataSource.fetchUserWishlists(
        "68eaae2a73f142e5115639f0",
      );
    },
  );
}
