import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWithChild extends StatelessWidget {
  final Widget child;
  const ShimmerWithChild({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.4),
      highlightColor: Colors.white.withOpacity(0.7),
      child: child,
    );
  }
}

class ShimmerHome extends StatelessWidget {
  final double h;
  final double w;
  final Color? color;

  const ShimmerHome({Key? key, required this.h, required this.w, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: color ?? const Color(0xffE6F1F3),
      highlightColor: Colors.white.withOpacity(0.7),
      child: SizedBox(
          width: w,
          height: h,
          child: Container(
            color: Colors.white,
          )),
    );
  }
}
