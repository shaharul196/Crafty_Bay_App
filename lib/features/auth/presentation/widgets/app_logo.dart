import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../app/assets_paths.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key, this.width,
  });

  final double? width;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(AssetsPaths.logosSvg,width: width ?? 125,);
  }
}
