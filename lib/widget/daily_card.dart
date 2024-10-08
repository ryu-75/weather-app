import 'package:embedded_weather_app/widget/daily_weather_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DailyCard extends StatelessWidget {
  final double temperature;
  const DailyCard({super.key, required this.temperature});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        alignment: Alignment.topCenter,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  Align(
                      alignment: const Alignment(0, -1),
                      child: Text(
                        "Daily",
                        style: GoogleFonts.redHatDisplay(
                            fontSize: 24,
                            color: Colors.blue.shade50,
                            letterSpacing: 4.0),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DailyWeatherData(
                          temperature: temperature,
                          period: '8:00',
                          icon: Icons.wb_twighlight),
                      DailyWeatherData(
                          temperature: temperature,
                          period: '12:00',
                          icon: Icons.sunny),
                      DailyWeatherData(
                          temperature: temperature,
                          period: '18:00',
                          icon: Icons.bedtime)
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      )
    ]);
  }
}
