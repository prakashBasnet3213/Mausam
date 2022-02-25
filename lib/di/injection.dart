import 'package:get_it/get_it.dart';
import 'package:mausam/data/core/api_client.dart';
import 'package:mausam/data/data_source/local_data_source.dart';
import 'package:mausam/data/data_source/remote_data_source.dart';
import 'package:mausam/data/repository/repository_impl.dart';
import 'package:mausam/domain/repository/repository.dart';
import 'package:mausam/domain/usecase/get_weather_from_location.dart';
import 'package:mausam/domain/usecase/get_weather_from_value.dart';
import 'package:mausam/presentation/bloc/ChangeLabel/changelabel_cubit.dart';
import 'package:mausam/presentation/bloc/GetWeather/getweather_cubit.dart';

var sl = GetIt.I;
void init() {
  //presentation layer
  sl.registerFactory(() => GetweatherCubit(sl(), sl(), sl()));
  sl.registerFactory(() => ChangelabelCubit());
  //domain layer
  sl.registerLazySingleton(() => GetWeatherFromLocation(sl()));
  sl.registerLazySingleton(() => GetWeatherFromValue(sl()));
  //data layer
  sl.registerLazySingleton<Repository>(() => RepositoryImpl(sl()));
  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<LocationStorage>(() => LocationStorageImpl());
  sl.registerLazySingleton(() => ApiClient());
}
