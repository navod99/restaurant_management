import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:async';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/main');
    });
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/lemon.jpg",
            height: size.height * 0.35,
          ),
          AnimatedText(
            text: 'Lemon Resturent',
            duration: const Duration(seconds: 2),
            textStyle: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ],
      )),
    );
  }
}

class AnimatedText extends StatelessWidget {
  final String text;
  final Duration duration;
  final TextStyle textStyle;

  AnimatedText({
    required this.text,
    required this.duration,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: duration,
      builder: (BuildContext context, double value, Widget? child) {
        return Opacity(
          opacity: value,
          child: Text(
            text,
            style: textStyle,
          ),
        );
      },
    );
  }
}
