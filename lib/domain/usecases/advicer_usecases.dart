import 'package:advice_app/domain/entities/advice_entity.dart';
import 'package:advice_app/domain/failures/failures.dart';
import 'package:dartz/dartz.dart';

class AdvicerUsecases {
  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    //TODO Implement Business Logic, e.g. calculations, etc.

    //TODO Call Function from Repository to get Advice

    return Right(AdviceEntity(advice: "Example", adviceID: 42));
  }

  Future<Either<Failure, AdviceEntity>> getFakeAdvice() async {
    await Future.delayed(const Duration(seconds: 2));
    // return Left(ServerFailure());
    return Right(AdviceEntity(advice: "Fake Data", adviceID: 420));
  }
}
