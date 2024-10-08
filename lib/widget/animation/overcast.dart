import 'package:flutter/material.dart';

class Overcast extends StatefulWidget {
  final IconData? firstIcon;
  final IconData? secondIcon;
  final Duration durationRainCloud;
  final Duration durationBlackCloud;
  final Curve curve;
  const Overcast({
    super.key,
    this.durationBlackCloud = const Duration(seconds: 4),
    this.durationRainCloud = const Duration(seconds: 3),
    this.curve = Curves.easeInCubic,
    required this.firstIcon,
    required this.secondIcon,
  });

  @override
  State<Overcast> createState() => _OvercastState();
}

class _OvercastState extends State<Overcast> with TickerProviderStateMixin {
  late AnimationController _controllerBlackCloud;
  late AnimationController _controllerRainCloud;
  late Animation<double> animationRainCloud;
  late Animation<double> animationBlackCloud;

  @override
  void initState() {
    super.initState();

    _controllerRainCloud = AnimationController(
      vsync: this,
      duration: widget.durationRainCloud,
    )..repeat(reverse: true);

    _controllerBlackCloud = AnimationController(
      vsync: this,
      duration: widget.durationBlackCloud,
    )..repeat(reverse: true);

    animationRainCloud =
        Tween<double>(begin: 280, end: 300).animate(CurvedAnimation(
      parent: _controllerRainCloud,
      curve: Curves.easeInOutCubic,
    ));

    animationBlackCloud =
        Tween<double>(begin: 250.0, end: 300.0).animate(CurvedAnimation(
      parent: _controllerBlackCloud,
      curve: Curves.easeInOutCubic,
    ));
  }

  @override
  void dispose() {
    _controllerBlackCloud.dispose();
    _controllerRainCloud.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: AlignmentDirectional.center,
        fit: StackFit.expand,
        children: [
          AnimatedBuilder(
            animation: animationBlackCloud,
            builder: (context, child) {
              return Positioned(
                  height: 200,
                  width: 200,
                  top: 10,
                  left: animationBlackCloud.value,
                  child: child!); // selected ? 250.0 : 300.0,
            },
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (_controllerBlackCloud.isAnimating) {
                    _controllerBlackCloud.stop();
                  } else {
                    _controllerBlackCloud.repeat(reverse: true);
                  }
                });
              },
              child: Icon(
                widget.firstIcon,
                size: 120,
                color: Colors.white,
                shadows: const [
                  BoxShadow(
                      color: Colors.black54,
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(1, 0))
                ],
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _controllerRainCloud,
            builder: (context, child) {
              return Positioned(
                  top: 60,
                  left: animationRainCloud.value,
                  child: child!); // selected ? 250.0 : 300.0,
            },
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (_controllerRainCloud.isAnimating) {
                    _controllerRainCloud.stop();
                  } else {
                    _controllerRainCloud.repeat(reverse: true);
                  }
                });
              },
              child: Icon(
                widget.secondIcon!,
                size: 106,
                color: Colors.grey.shade400,
                shadows: const [
                  BoxShadow(
                      color: Colors.black54,
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(1, -1))
                ],
              ),
            ),
          ),
        ]);
  }
}
