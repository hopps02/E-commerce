import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store/presentation/res/gen/assets.gen.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        Assets.lottieAnimations.succesfull.path,
        key: Key("Key"),
        width: 1.sw,
        height: 378.h,
        repeat: false,
        fit: BoxFit.contain,
      ),
    );
  }
}
