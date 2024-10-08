import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Weather> fetchData() async {
  final response = await http.get(Uri.parse(
      "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current=temperature_2m,pressure_msl,"));

  if (response.statusCode == 200) {
    return Weather.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception("Failed to load data");
  }
}

class Weather {
  final double temperature;
  final double pressure;

  const Weather({
    required this.temperature,
    required this.pressure,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    var currentWeather = json['current'];
    if (currentWeather != null) {
      return Weather(
        temperature: currentWeather['temperature_2m'] as double,
        pressure: currentWeather['pressure_msl'] as double,
      );
    } else {
      throw const FormatException("Invalid data received");
    }
  }
}
