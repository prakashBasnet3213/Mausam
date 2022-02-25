import 'package:mausam/data/core/api_client.dart';
import 'package:mausam/data/model/weather_model.dart';

abstract class RemoteDataSource {
  Future<WeatherModel> getWeatherFromLocation(String location);
  Future<WeatherModel> getWeatherFromValue(double latitude, double longitude);
}

class RemoteDataSourceImpl extends RemoteDataSource {
  final ApiClient _apiClient;
  RemoteDataSourceImpl(this._apiClient);
  @override
  Future<WeatherModel> getWeatherFromLocation(String location) async {
    var response = await _apiClient.getWeatherFromLocation(location);
    WeatherModel weatherModel = weatherModelFromJson(response);
    return weatherModel;
  }

  @override
  Future<WeatherModel> getWeatherFromValue(
      double latitude, double longitude) async {
    var response = await _apiClient.getWeatherFromValue(latitude, longitude);
    WeatherModel weatherModel = weatherModelFromJson(response);
    return weatherModel;
  }
}
