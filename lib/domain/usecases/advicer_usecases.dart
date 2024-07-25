import 'package:advice_app/domain/entities/advice_entity.dart';
import 'package:advice_app/domain/failures/failures.dart';
import 'package:advice_app/domain/repositories/advicer_repository.dart';
import 'package:advice_app/infrastructure/repositories/advicer_repository_impl.dart';
import 'package:dartz/dartz.dart';

class AdvicerUsecases {
  final AdvicerRepository advicerRepository = AdvicerRepositoryImpl();

  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    //FUTURE Implement Business Logic, e.g. calculations, etc.
    return advicerRepository.getAdviceFromAPI();
  }

  Future<Either<Failure, AdviceEntity>> getFakeAdvice() async {
    await Future.delayed(const Duration(seconds: 2));
    // return Left(ServerFailure());
    return Right(AdviceEntity(advice: "Fake Data", adviceID: 420));
  }
}
