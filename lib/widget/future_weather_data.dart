import 'package:embedded_weather_app/widget/api/api.dart';
import 'package:embedded_weather_app/widget/daily_card.dart';
import 'package:embedded_weather_app/widget/displaying_animation.dart';
import 'package:flutter/material.dart';

class FutureWeatherData extends StatefulWidget {
  const FutureWeatherData({super.key});

  @override
  State<FutureWeatherData> createState() => _FutureWeatherDataState();
}

class _FutureWeatherDataState extends State<FutureWeatherData> {
  late Future<Weather> futureWeather;

  @override
  void initState() {
    super.initState();
    futureWeather = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Weather>(
        future: futureWeather,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return LayoutBuilder(builder: (context, constraints) {
              return Stack(
                children: [
                  Align(
                    alignment: const Alignment(0, 0),
                    child: FractionallySizedBox(
                      widthFactor: 0.8,
                      heightFactor: 1,
                      child: DisplayingAnimation(
                        pressure: snapshot.data!.pressure,
                        temperature: snapshot.data!.temperature,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0.0, 1),
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      heightFactor: 0.30,
                      child: DailyCard(temperature: snapshot.data!.temperature),
                    ),
                  ),
                ],
              );
            });
          } else if (snapshot.hasError) {
            return LayoutBuilder(builder: (context, constraints) {
              return Stack(
                children: [
                  Align(
                    alignment: const Alignment(0, 0),
                    child: FractionallySizedBox(
                      widthFactor: 0.8,
                      heightFactor: 0.8,
                      child: DisplayingAnimation(
                        pressure: snapshot.data!.pressure,
                        temperature: snapshot.data!.temperature,
                      ),
                    ),
                  ),
                  DailyCard(temperature: snapshot.data!.temperature),
                ],
              );
            });
          }
          return const CircularProgressIndicator();
        });
  }
}
