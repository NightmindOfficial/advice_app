import 'package:advice_app/domain/entities/advice_entity.dart';
import 'package:advice_app/domain/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class AdvicerRepository {
  Future<Either<Failure, AdviceEntity>> getAdviceFromAPI();
}
