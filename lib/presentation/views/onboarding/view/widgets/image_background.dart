import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jar/presentation/res/gen/assets.gen.dart';

class ImageBackground extends StatelessWidget {
  const ImageBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.images.onBoardingImage.path,
      width: double.infinity,
      height: 0.7.sh,
      fit: BoxFit.cover,
    );
  }
}
