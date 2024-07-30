import 'package:advice_app/domain/entities/advice_entity.dart';
import 'package:equatable/equatable.dart';

class AdviceModel extends AdviceEntity with EquatableMixin {
  AdviceModel({required super.advice, required super.adviceID});

  factory AdviceModel.fromJson(Map<String, dynamic> json) {
    return AdviceModel(
      advice: json['advice'],
      adviceID: json['id'],
    );
  }

  @override
  List<Object?> get props => [advice, adviceID];
}
