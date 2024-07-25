import 'package:advice_app/domain/entities/advice_entity.dart';

class AdviceModel extends AdviceEntity {
  AdviceModel({required super.advice, required super.adviceID});

  factory AdviceModel.fromJson(Map<String, dynamic> json) {
    return AdviceModel(
      advice: json['advice'],
      adviceID: json['id'],
    );
  }
}
