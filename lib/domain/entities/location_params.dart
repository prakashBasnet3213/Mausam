import 'package:equatable/equatable.dart';

class LocationParams extends Equatable {
  final String location;
  const LocationParams({required this.location});
  @override
  List<Object?> get props => [location];
}
