import 'package:embedded_weather_app/widget/animation/clear_sky.dart';
import 'package:embedded_weather_app/widget/animation/overcast.dart';
import 'package:embedded_weather_app/widget/meteo_card_value.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Add a new prototype later to finded the correct image for each animation
IconData? selectIcons(double pressure, String? position) {
  const Map<int, IconData> animationOne = <int, IconData>{
    995: Icons.thunderstorm,
    1005: Icons.cloud,
    1020: Icons.sunny,
  };
  const Map<int, IconData> animationTwo = <int, IconData>{
    995: Icons.storm,
    1005: Icons.cloud,
    1015: Icons.nights_stay,
    1020: Icons.bedtime,
  };

  for (var one in animationOne.keys.toList().reversed) {
    for (var two in animationTwo.keys.toList().reversed) {
      if (one <= pressure && position == 'first') {
        return animationOne[one];
      } else if (pressure >= two && position == 'second') {
        return animationTwo[two];
      }
    }
  }
  return Icons.bedtime;
}

String? selectWeatherState(double pressure) {
  if (pressure >= 995 && pressure < 1000) {
    return 'Thunderstorm';
  } else if (pressure >= 1000 && pressure < 1005) {
    return 'Rain';
  } else if (pressure >= 1005 && pressure < 1010) {
    return 'Overcast';
  } else if (pressure >= 1010 && pressure < 1015) {
    return 'Partially overcast';
  } else if (pressure >= 1020) {
    return 'Clear';
  }
  return 'No data available';
}

class DisplayingAnimation extends StatefulWidget {
  final double pressure;
  final double temperature;

  const DisplayingAnimation(
      {super.key, required this.pressure, required this.temperature});

  @override
  State<DisplayingAnimation> createState() => _DisplayingAnimationState();
}

class _DisplayingAnimationState extends State<DisplayingAnimation> {
  final GlobalKey _cardKey = GlobalKey();
  double cardHeight = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getCardSize();
    });
  }

  void _getCardSize() {
    final RenderBox box =
        _cardKey.currentContext!.findRenderObject() as RenderBox;
    setState(() {
      cardHeight = box.size.height;
    });
  }

  // Create a method which will set the right text from pressure
  @override
  Widget build(BuildContext context) {
    IconData? selectFirstIcon = selectIcons(widget.pressure, "first");
    IconData? selectSecondIcon = selectIcons(widget.pressure, "second");
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          width: 700,
          height: 700,
          top: -10,
          child: widget.pressure < 1010
              ? ClearSky(icons: selectFirstIcon)
              : Overcast(
                  firstIcon: selectFirstIcon,
                  secondIcon: selectSecondIcon,
                ),
        ),
        Align(
          alignment: const Alignment(0, -0.6),
          child: Text(
            '${selectWeatherState(widget.pressure)}',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 28),
          ),
        ),
        Align(
          alignment: const Alignment(1, -0.3),
          child: DisplayingHumPressWind(pressure: widget.pressure),
        ),
        Positioned(
            top: MediaQuery.of(context).size.height * 0.30,
            child: CardMeteoValue(key: _cardKey, value: widget.temperature)),
      ],
    );
  }
}

class DisplayingHumPressWind extends StatelessWidget {
  final double pressure;
  final double humidity = 0.0;
  final double winds = 0.0;

  const DisplayingHumPressWind(
      {super.key, required this.pressure, winds, humidity});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 200,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Flex(
              direction: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                HumPressWindContent(
                    value: pressure,
                    alignment: const Alignment(-1, -1),
                    icon: Icons.speed),
                HumPressWindContent(
                  value: pressure,
                  alignment: Alignment.topCenter,
                  icon: Icons.water_drop,
                  state: '%',
                ),
                HumPressWindContent(
                  value: pressure,
                  alignment: Alignment.topRight,
                  icon: Icons.air,
                  state: 'km/h',
                ),
              ],
            ),
          ],
        ));
  }
}

class HumPressWindContent extends StatelessWidget {
  final double value;
  final IconData icon;
  final Alignment alignment;
  final String state;
  const HumPressWindContent(
      {super.key,
      required this.value,
      required this.icon,
      required this.alignment,
      this.state = 'hPa'});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(alignment: alignment, child: Icon(icon, color: Colors.white)),
        const SizedBox(height: 10),
        Text(
          '$value $state',
          style: GoogleFonts.redHatDisplay(fontSize: 16, color: Colors.white),
        )
      ],
    );
  }
}
