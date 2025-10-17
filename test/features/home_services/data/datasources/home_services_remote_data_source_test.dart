import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:yelpax/core/network/dio_client.dart';
import 'package:yelpax/core/network/endpoints.dart';
import 'package:yelpax/features/home_services/data/datasources/home_services_remote_data_source.dart';
import 'package:yelpax/features/home_services/data/models/home_service_promotion_model.dart';
import 'package:yelpax/features/home_services/data/models/home_services_fetch_professional_model.dart';
import 'package:yelpax/features/home_services/data/models/home_services_model.dart';

class MockClient extends Mock implements DioClient {}

void main() {
test(
  "Testing the data source if the response is coming and valid or not",
  () async {
    final client = MockClient();
    final datasource = HomeServicesRemoteDataSourceImpl(dioClient: client);

    when(
      client.post(
        Endpoints.findpros,
        data: {"serviceId": "68efa2985970185920dcb930", "zipCode": "92101"},
      ),
    ).thenAnswer(
      (_) async => Response(
        data: {
          'data': [
            {"id": "1", "name": "Professional 1"},
            {"id": "2", "name": "Professional 2"},
          ],
        },
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );

    final result = await datasource.fetchProsByServiceAndZip(
      "68efa2985970185920dcb930",
      "92101",
    );

    expect(result.length, 1);
    expect(result[0].maximumPrice, 150);
    expect(result[0].pricingType, "fixed");
  },
);


}