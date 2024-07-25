import 'dart:convert';

import 'package:advice_app/domain/entities/advice_entity.dart';
import 'package:advice_app/infrastructure/exceptions/exceptions.dart';
import 'package:advice_app/infrastructure/models/advice_model.dart';
import 'package:http/http.dart' as http;

abstract class AdvicerRemoteDatasource {
  /// Requests a random quote / advice from FreeAPI.
  /// Throws a [ServerException] if the response code is not 200 (OK).
  Future<AdviceEntity> getRandomAdviceFromAPI();
}

class AdvicerRemoteDatasourceImpl implements AdvicerRemoteDatasource {
  final http.Client client = http.Client();

  @override
  Future<AdviceEntity> getRandomAdviceFromAPI() async {
    final response = await client.get(
      Uri.parse("https://api.adviceslip.com/advice"),
      headers: {
        'Content-type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      final responseBody = json.decode(response.body);

      return AdviceModel.fromJson(responseBody['slip']);
    }
  }
}
