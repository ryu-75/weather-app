import 'dart:async';

import 'package:embedded_weather_app/widget/animation/shimmer.dart';
import 'package:embedded_weather_app/widget/future_weather_data.dart';
import 'package:flutter/material.dart';

// Managed visual effect with the current date
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather room',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: "Weather home"),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Main class
class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Timer(const Duration(seconds: 1), handleTimeout);
  }

  void handleTimeout() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
          length: 0,
          child: Scaffold(
            body: Shimmer(
              linearGradient: shimmerGradient,
              child: Container(
                child: _buildLoadingScreen(),
              ),
            ),
          )),
      debugShowCheckedModeBanner: false,
    );
  }

  Widget _buildLoadingScreen() {
    return ShimmerLoading(
        isLoading: _isLoading,
        child: ScreenItem(
          isLoading: _isLoading,
        ));
  }
}

class FilledTextFieldExample extends StatelessWidget {
  const FilledTextFieldExample({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: const TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          suffixIcon: Icon(Icons.clear),
          labelText: 'Search',
          filled: true,
        ),
      ),
    );
  }
}

class ScreenItem extends StatefulWidget {
  final bool isLoading;
  final bool enabled = true;
  const ScreenItem({super.key, required this.isLoading, enabled});

  @override
  State<ScreenItem> createState() => _ScreenItemState();
}

bool isHovering = false;

class _ScreenItemState extends State<ScreenItem> {
  @override
  Widget build(BuildContext context) {
    final VoidCallback? onPressed = widget.enabled ? () {} : null;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        shadowColor: Colors.blue.shade800,
        title: const Padding(
          padding: EdgeInsets.only(top: 15, bottom: 15),
          child: FilledTextFieldExample(),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: onPressed,
            child: Icon(
              Icons.near_me,
              color: Colors.white,
              size: 30,
              shadows: [
                BoxShadow(
                    color: Colors.blue.shade900,
                    blurRadius: 1,
                    spreadRadius: 2,
                    offset: const Offset(1, 1))
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue.shade800,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                tooltip: 'Home',
                icon: const Icon(Icons.home),
                onPressed: () {},
              ),
              IconButton(
                tooltip: 'Open navigation menu',
                icon: const Icon(Icons.today),
                onPressed: () {},
              ),
              IconButton(
                tooltip: 'Search',
                icon: const Icon(Icons.date_range_sharp),
                onPressed: () {},
              ),
              IconButton(
                tooltip: 'Favorite',
                icon: const Icon(Icons.calendar_month),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            // Gradient background colors
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.blue.shade200,
                const Color.fromARGB(255, 73, 167, 243),
                const Color.fromARGB(255, 73, 167, 243),
                const Color.fromARGB(255, 105, 192, 238),
                Colors.blue.shade200,
              ], begin: Alignment.bottomLeft, end: Alignment.topRight),
            ),
          ),
          ClipPath(
            clipper: CustomClipPath(),
            child: Container(
              // Gradient background colors
              height: 680,
              decoration: BoxDecoration(
                color: Colors.blue.shade800,
              ),
            ),
          ),
          ClipPath(
            clipper: CustomClipPath(),
            child: Container(
              // Gradient background colors
              height: 620,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.blue.shade200,
                  const Color.fromARGB(255, 73, 167, 243),
                  const Color.fromARGB(255, 73, 167, 243),
                  const Color.fromARGB(255, 105, 192, 238),
                  Colors.blue.shade200,
                ], begin: Alignment.bottomLeft, end: Alignment.topRight),
              ),
            ),
          ),
          const FutureWeatherData(),
        ],
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    final path = Path();

    // (0, 0) // 1. point
    path.lineTo(0, h * 0.7);
    path.cubicTo(w * 0.65, h, w, h * 0.5, w + 500, h * 0.6);
    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
