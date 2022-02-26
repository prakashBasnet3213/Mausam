import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mausam/data/data_source/local_data_source.dart';
import 'package:mausam/domain/entities/refined_weather.dart';
import 'package:mausam/domain/usecase/get_weather_from_location.dart';
import 'package:mausam/domain/usecase/get_weather_from_value.dart';
import 'package:mausam/presentation/bloc/GetWeather/getweather_cubit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'get_weather_cubit_test.mocks.dart';

@GenerateMocks(
  [
    GetWeatherFromLocation,
    GetWeatherFromValue,
    LocationStorage,
    SharedPreferences,
  ],
)
void main() {
  const fakeData = RefinedWeatherModel(
    name: "",
    tempC: 0,
    tempF: 0,
    isDay: 0,
    country: "",
    region: "",
    icon: "",
    text: "",
  );
  group(
    'Get Weather Cubit',
    () {
      late GetweatherCubit _getWeatherCubit;
      late MockGetWeatherFromLocation _fromLocation;
      late MockGetWeatherFromValue _fromValueRepository;
      late MockLocationStorage _fromLocationStorage;
      setUp(
        () {
          _fromLocation = MockGetWeatherFromLocation();
          _fromValueRepository = MockGetWeatherFromValue();
          _fromLocationStorage = MockLocationStorage();
          _getWeatherCubit = GetweatherCubit(
            _fromLocation,
            _fromValueRepository,
            _fromLocationStorage,
          );
        },
      );
      tearDown(
        () {
          _getWeatherCubit.close();
        },
      );

      void stubGetLocation() {
        when(_fromLocationStorage.getLocation())
            .thenAnswer((realInvocation) => "");
      }

      void stubSetLocation() {
        when(_fromLocationStorage.setLocation("London"))
            .thenAnswer((realInvocation) async => Future.value(true));
      }

      void stubRemoveLocation() {
        when(_fromLocationStorage.removeLocation())
            .thenAnswer((realInvocation) async => Future.value(true));
      }

      blocTest<GetweatherCubit, GetweatherState>(
        'Emits loading and loaded state when get weather from location is called',
        build: () => _getWeatherCubit,
        act: (GetweatherCubit cubit) {
          stubGetLocation();
          stubSetLocation();
          stubRemoveLocation();
          when(_fromLocation.call(any)).thenAnswer(
            (_) async => const Right(fakeData),
          );
          cubit.getWeatherFromLocation("London");
        },
        expect: () => [
          isA<GetweatherLoading>(),
          isA<GetweatherLoaded>(),
        ],
        // verify: (GetweatherCubit cubit) {
        //   verify(cubit.getWeatherFromLocation("London")).called(1);
        // },
      );
    },
  );
}
