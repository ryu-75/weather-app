import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.shade50
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // Always repaint to update the line position.
  }
}

class DailyWeatherData extends StatelessWidget {
  final double temperature;
  final String period;
  final IconData icon;
  const DailyWeatherData(
      {super.key,
      required this.temperature,
      required this.period,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: const Alignment(0, -0.3),
          child: Icon(
            icon,
            size: 20,
            color: Colors.white,
          ),
        ),
        Align(
          alignment: const Alignment(0, 0.1),
          child: Text(
            period,
            style: GoogleFonts.redHatDisplay(
              fontSize: 16,
              fontWeight: FontWeight.w200,
              color: Colors.white,
            ),
          ),
        ),
        Align(
          alignment: const Alignment(0, 0.5),
          child: Text(
            '$temperature°C',
            style: GoogleFonts.redHatDisplay(
              fontSize: 28,
              fontWeight: FontWeight.w200,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
