import 'package:mausam/common/exception/app_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:mausam/domain/entities/lat_long_params.dart';
import 'package:mausam/domain/entities/refined_weather.dart';
import 'package:mausam/domain/repository/repository.dart';
import 'package:mausam/domain/usecase/usecase.dart';

class GetWeatherFromValue extends Usecase<RefinedWeatherModel, LatLongParams> {
  final Repository _repository;
  GetWeatherFromValue(this._repository);
  @override
  Future<Either<AppError, RefinedWeatherModel>> call(LatLongParams p) async {
    return await _repository.getWeatherFromValue(p.latitude, p.longitude);
  }
}
