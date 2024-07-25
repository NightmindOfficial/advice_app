import 'package:advice_app/domain/entities/advice_entity.dart';

class AdvicerUsecases {
  Future<AdviceEntity> getAdvice() async {
    //TODO Implement Business Logic, e.g. calculations, etc.

    //TODO Call Function from Repository to get Advice

    return AdviceEntity(advice: "Example", adviceID: 42);
  }

  Future<AdviceEntity> getFakeAdvice() async {
    await Future.delayed(const Duration(seconds: 2));
    return AdviceEntity(advice: "Fake Data", adviceID: 420);
  }
}
