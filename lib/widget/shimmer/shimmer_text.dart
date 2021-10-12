import 'package:flutter/material.dart';
import 'package:fluvie/resource/styles/dimens.dart';

class ShimmerText extends StatelessWidget {
  final double? width;
  final double? height;

  const ShimmerText({this.width, this.height, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(Dimens.spacingSmall)),
      ),
      width: width ?? double.infinity,
      height: height ?? Dimens.textNormal,
    );
  }
}
