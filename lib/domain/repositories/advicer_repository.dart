import 'package:advice_app/domain/entities/advice_entity.dart';

abstract class AdvicerRepository {
  Future<AdviceEntity> getAdviceFromAPI();
}
