import 'dart:io';

import 'package:mausam/data/data_source/remote_data_source.dart';
import 'package:mausam/domain/entities/refined_weather.dart';
import 'package:mausam/common/exception/app_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:mausam/domain/repository/repository.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSource _remoteDataSource;
  RepositoryImpl(this._remoteDataSource);
  @override
  Future<Either<AppError, RefinedWeatherModel>> getWeatherFromLocation(
      String location) async {
    try {
      var response = await _remoteDataSource.getWeatherFromLocation(location);
      return Right(response);
    } on SocketException {
      return const Left(AppError(type: AppErrorType.network));
    } on BadRequestException {
      return const Left(AppError(type: AppErrorType.badRequest));
    } on HttpException {
      return const Left(AppError(type: AppErrorType.server));
    }
  }

  @override
  Future<Either<AppError, RefinedWeatherModel>> getWeatherFromValue(
      double latitude, double longitude) async {
    try {
      var response =
          await _remoteDataSource.getWeatherFromValue(latitude, longitude);
      return Right(response);
    } on SocketException {
      return const Left(AppError(type: AppErrorType.network));
    } on HttpException {
      return const Left(AppError(type: AppErrorType.server));
    }
  }
}
