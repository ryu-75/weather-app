import 'package:flutter/material.dart';

// Changed class name
// Handle the animation movement of the moon

class ClearSky extends StatefulWidget {
  final IconData? icons;
  final Duration duration;
  final Curve curve;
  const ClearSky(
      {super.key,
      this.duration = const Duration(seconds: 4),
      this.curve = Curves.easeInOut,
      required this.icons});

  @override
  State<ClearSky> createState() => _ClearSkyState();
}

class _ClearSkyState extends State<ClearSky> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationController;
  late AnimationController _rotationController;
  late Animation<double> _rotationAnimationController;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat(reverse: true);

    _animationController =
        Tween<double>(begin: 200, end: 300).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat(reverse: false);

    _rotationAnimationController =
        Tween<double>(begin: 0.0, end: 0.5).animate(_rotationController)
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  void dispose() {
    _controller.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      fit: StackFit.expand,
      children: [
        if (widget.icons != Icons.sunny)
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Positioned(
                  height: 200,
                  width: 200,
                  top: 10,
                  left: _animationController.value,
                  child: child!); // selected ? 250.0 : 300.0,
            },
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (_controller.isAnimating) {
                    _controller.stop();
                  } else {
                    _controller.repeat(reverse: true);
                  }
                });
              },
              child: Icon(
                widget.icons,
                size: 120,
                color: Colors.white,
                shadows: const [
                  BoxShadow(
                      color: Colors.black45,
                      blurStyle: BlurStyle.outer,
                      blurRadius: 2,
                      spreadRadius: 10)
                ],
              ),
            ),
          )
        else
          AnimatedBuilder(
            animation: _rotationAnimationController,
            builder: (context, child) {
              return Positioned(
                  height: 200,
                  width: 200,
                  top: 0,
                  child: child!); // selected ? 250.0 : 300.0,
            },
            child: RotationTransition(
              turns: _rotationAnimationController,
              child: Icon(
                widget.icons,
                size: 120,
                color: Colors.amber.shade300,
                shadows: const [
                  BoxShadow(
                      color: Color.fromARGB(193, 255, 233, 199),
                      blurRadius: 12,
                      offset: Offset(0, 0),
                      spreadRadius: 12)
                ],
              ),
            ),
          ),
      ],
    );
  }
}
