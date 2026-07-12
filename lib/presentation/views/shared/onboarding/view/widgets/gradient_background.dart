import 'package:flutter/material.dart';
import 'package:store/presentation/res/color_manager.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.25, 0.7],
          colors: [ColorM.transparent, ColorM.primary900],
        ),
      ),
    );
  }
}
