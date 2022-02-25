import 'package:dartz/dartz.dart';
import 'package:mausam/common/exception/app_exception.dart';
import 'package:mausam/domain/entities/refined_weather.dart';

abstract class Repository {
  Future<Either<AppError, RefinedWeatherModel>> getWeatherFromLocation(String location);
  Future<Either<AppError, RefinedWeatherModel>> getWeatherFromValue(double latitude, double longitude);
}
