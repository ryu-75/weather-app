import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardMeteoValue extends StatelessWidget {
  final double value;
  const CardMeteoValue({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text('${value.toString()}${value > 50 ? ' hPa' : '°C'}',
                textAlign: TextAlign.center,
                style: GoogleFonts.redHatDisplay(
                    fontSize: 120,
                    color: Colors.amber.shade50,
                    shadows: const [
                      BoxShadow(
                          color: Colors.black54,
                          blurRadius: 1.7,
                          spreadRadius: 2)
                    ]))
          ])
        ]);
  }
}
