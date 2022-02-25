import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mausam/common/exception/app_exception.dart';
import 'package:mausam/data/data_source/local_data_source.dart';
import 'package:mausam/domain/entities/lat_long_params.dart';
import 'package:mausam/domain/entities/location_params.dart';
import 'package:mausam/domain/entities/refined_weather.dart';
import 'package:mausam/domain/usecase/get_weather_from_location.dart';
import 'package:mausam/domain/usecase/get_weather_from_value.dart';

part 'getweather_state.dart';

class GetweatherCubit extends Cubit<GetweatherState> {
  final GetWeatherFromLocation _getWeatherFromLocation;
  final GetWeatherFromValue _getWeatherFromValue;
  final LocationStorage _locationStorage;
  GetweatherCubit(
    this._getWeatherFromLocation,
    this._getWeatherFromValue,
    this._locationStorage,
  ) : super(GetweatherInitial());
  double _latitude = 27.700769;
  double _longitude = 85.300140;
  String? _lastSearched;

  void getWeatherFromLocalStorage() async {
    String location = _locationStorage.getLocation();
    if (location != "error") {
      _lastSearched = location;
      getWeatherFromLocation(location);
    } else {
      getWeatherFromValue();
    }
  }

  void getWeatherFromLocation(String location) async {
    emit(GetweatherLoading());
    var response =
        await _getWeatherFromLocation(LocationParams(location: location));
    response.fold(
      (l) => emit(GetweatherFailed(type: l.type)),
      (r) async {
        if (_locationStorage.getLocation() == "error") {
          bool isSaved = await _locationStorage.setLocation(location);
          if (isSaved) {
            _lastSearched = location;
          }
        } else {
          await _locationStorage.removeLocation();
          bool isSaved = await _locationStorage.setLocation(location);
          if (isSaved) {
            _lastSearched = location;
          }
        }
        print("last saved location is $_lastSearched");
        emit(
          GetweatherLoaded(
            model: r,
            lastSearched: _lastSearched,
          ),
        );
      },
    );
  }

  void getWeatherFromValue() async {
    emit(GetweatherLoading());
    var response = await _getWeatherFromValue(
        LatLongParams(latitude: _latitude, longitude: _longitude));
    response.fold(
      (l) => emit(GetweatherFailed(type: l.type)),
      (r) => emit(
        GetweatherLoaded(
          model: r,
          lastSearched: _lastSearched,
        ),
      ),
    );
  }

  void getMyLatLong() async {
    _latitude = 12;
    _longitude = 14;
  }
}
