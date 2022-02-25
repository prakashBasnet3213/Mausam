class RefinedWeatherModel {
  final String name;
  final String country;
  final String region;
  final double tempC;
  final double tempF;
  final int isDay;
  final String text;
  final String icon;
  const RefinedWeatherModel({
    required this.name,
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.country,
    required this.region,
    required this.icon,
    required this.text,
  });
}
