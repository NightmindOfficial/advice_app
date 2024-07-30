import 'package:advice_app/domain/entities/advice_entity.dart';
import 'package:advice_app/domain/failures/failures.dart';
import 'package:advice_app/domain/repositories/advicer_repository.dart';
import 'package:advice_app/infrastructure/datasources/advicer_remote_datasource.dart';
import 'package:advice_app/infrastructure/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';

class AdvicerRepositoryImpl implements AdvicerRepository {
  final AdvicerRemoteDatasource advicerRemoteDatasource;

  AdvicerRepositoryImpl({required this.advicerRemoteDatasource});

  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromAPI() async {
    try {
      final remoteAdvice =
          await advicerRemoteDatasource.getRandomAdviceFromAPI();
      return Right(remoteAdvice);
    } catch (e) {
      switch (e.runtimeType) {
        case const (ServerException):
          return Left(ServerFailure());
        default:
          return Left(GeneralFailure());
      }
    }
  }
}
