import 'dart:convert';

import 'package:advice_app/domain/entities/advice_entity.dart';
import 'package:advice_app/infrastructure/models/advice_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final tAdviceModel = AdviceModel(advice: "Der Lachs löppt.", adviceID: 69);

  test("Model should be Subclass of AdviceEntity", () {
    //Assert
    expect(tAdviceModel, isA<AdviceEntity>());
  });

  group("fromJson Factory", () {
    test("Should return a valid model if the JSON Advice is correct", () {
      // Arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture("advice.json"));

      // Act
      final result = AdviceModel.fromJson(jsonMap);
      // Assert
      expect(result, tAdviceModel);
    });
  });
}
