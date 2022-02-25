import 'package:dartz/dartz.dart';
import 'package:mausam/common/exception/app_exception.dart';

abstract class Usecase<Type, Params> {
  Future<Either<AppError, Type>> call(Params p);
}
