import 'package:mausam/common/exception/app_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:mausam/domain/entities/location_params.dart';
import 'package:mausam/domain/entities/refined_weather.dart';
import 'package:mausam/domain/repository/repository.dart';
import 'package:mausam/domain/usecase/usecase.dart';

class GetWeatherFromLocation
    extends Usecase<RefinedWeatherModel, LocationParams> {
  final Repository repository;
  GetWeatherFromLocation(this.repository);
  @override
  Future<Either<AppError, RefinedWeatherModel>> call(LocationParams p) async {
   return await repository.getWeatherFromLocation(p.location);
  }
}
