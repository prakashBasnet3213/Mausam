import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
  // by default latitude and longitude is inserted;
  double _latitude = 0;
  double _longitude = 0;
  String _lastSearched = "";

  void getWeatherFromLocalStorage() async {
    String location = _locationStorage.getLocation();
    if (location != "error") {
      _lastSearched = location;
      getWeatherFromLocation(location);
    } else {
      getWeatherFromValues();
    }
  }

  void getWeatherFromLocation(String location) async {
    emit(GetweatherLoading());
    var response =
        await _getWeatherFromLocation(LocationParams(location: location));
    response.fold(
      (l) => emit(GetweatherFailed(type: l.type)),
      (r) async {
        await _saveToDataBase(location);
        emit(
          GetweatherLoaded(
            model: r,
            lastSearched: _lastSearched,
          ),
        );
      },
    );
  }

  Future<void> _getCurrentLatitudeLongitude() async {
    // here location accuray is medium, to get the fast response while
    var location = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.medium,
    );
    _latitude = location.latitude;
    _longitude = location.longitude;
    debugPrint("$_latitude , $_longitude");
  }

  Future<bool> _checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    } else {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return false;
        }
      }
    }
    return true;
  }

  Future<void> _saveToDataBase(String location) async {
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
  }

  void getWeatherFromValues() async {
    emit(GetweatherLoading());
    bool isAccessed = await _checkLocationPermission();
    if (isAccessed) {
      if (_latitude == 0 && _longitude == 0) {
        await _getCurrentLatitudeLongitude();
      }
      var response = await _getWeatherFromValue(
        LatLongParams(latitude: _latitude, longitude: _longitude),
      );
      response.fold(
        (l) => emit(
          GetweatherFailed(type: l.type),
        ),
        (r) async {
          emit(
            GetweatherLoaded(
              model: r,
              lastSearched: _lastSearched,
            ),
          );
        },
      );
    } else {
      emit(const GetweatherFailed(type: AppErrorType.empty));
    }
  }
}
