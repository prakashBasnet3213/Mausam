import 'package:equatable/equatable.dart';

class LatLongParams extends Equatable {
  final double latitude;
  final double longitude;
  const LatLongParams({required this.latitude, required this.longitude});
  @override
  List<Object?> get props => [latitude, longitude];
}
