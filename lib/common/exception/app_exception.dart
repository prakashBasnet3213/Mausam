import 'package:equatable/equatable.dart';

enum AppErrorType { network, server, badRequest }

class AppError extends Equatable {
  final AppErrorType type;
  const AppError({required this.type});

  @override
  List<Object?> get props => [type];
}

class BadRequestException implements Exception {}

class HttpException implements Exception {}
