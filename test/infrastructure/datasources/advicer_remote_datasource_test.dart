import 'package:advice_app/infrastructure/datasources/advicer_remote_datasource.dart';
import 'package:advice_app/infrastructure/exceptions/exceptions.dart';
import 'package:advice_app/infrastructure/models/advice_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_reader.dart';
import 'advicer_remote_datasource_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;
  late AdvicerRemoteDatasource advicerRemoteDatasource;

  setUp(() {
    mockClient = MockClient();
    advicerRemoteDatasource = AdvicerRemoteDatasourceImpl(client: mockClient);
  });

  void setUpMockClientSuccess200() {
    // Arrange
    when(mockClient.get(any, headers: anyNamed("headers"))).thenAnswer(
      (_) async => http.Response(fixture("advice_http_response.json"), 200),
    );
  }

  void setUpMockClientFailure404() {
    // Arrange
    when(mockClient.get(any, headers: anyNamed("headers"))).thenAnswer(
      (_) async => http.Response("Not Found", 404),
    );
  }

  group("getRandomAdviceFromAPI", () {
    final tAdviceModel = AdviceModel(advice: "Der Lachs löppt.", adviceID: 69);

    test(
        "Datasource should perform get request to correct API URI & Header application/json",
        () {
      // Arrange
      setUpMockClientSuccess200();
      // Act
      advicerRemoteDatasource.getRandomAdviceFromAPI();
      // Assert
      verify(mockClient.get(
        Uri.parse("https://api.adviceslip.com/advice"),
        headers: {
          'Content-type': 'application/json',
        },
      ));
    });

    test("Should return advice on successful response (200)", () async {
      // Arrange
      setUpMockClientSuccess200();
      // Act
      final result = await advicerRemoteDatasource.getRandomAdviceFromAPI();
      // Assert
      expect(result, tAdviceModel);
    });

    test("Should throw ServerException if response code is not 200", () async {
      // Arrange
      setUpMockClientFailure404();
      // Act
      final call = advicerRemoteDatasource.getRandomAdviceFromAPI;
      // Assert
      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
