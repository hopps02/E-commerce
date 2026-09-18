import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:store/app/config/brand.dart';
import 'package:store/app/extensions/widget_extensions.dart';
import 'package:store/presentation/res/gen/assets.gen.dart';

import '../../../../../res/color_manager.dart';

/// The store's logo: the one the panel uploaded, or the app's own mark in the
/// store's colour when nobody has uploaded one.
class Logo extends StatelessWidget {
  final double width;

  const Logo({super.key, this.width = 155});

  @override
  Widget build(BuildContext context) {
    final logo = Brand.logoUrl;

    if (logo != null) {
      return Image.network(
        logo,
        width: width,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stack) => _mark(width),
      ).premiumAppear(index: 0);
    }

    return _mark(width).premiumAppear(index: 0);
  }
}

Widget _mark(double width) => SvgPicture.asset(
  Assets.svg.appLogo.path,
  width: width,
  colorFilter: ColorFilter.mode(ColorM.primary700, BlendMode.srcIn),
);
