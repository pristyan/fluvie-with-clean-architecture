import 'package:flutter/material.dart';

class ShimmerAvatar extends StatelessWidget {
  final double size;

  const ShimmerAvatar({
    required this.size,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      width: size,
      height: size,
    );
  }
}
