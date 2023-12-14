import 'package:alquran/global.dart';
import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    Key? key,
    required this.child,
    this.vPadding = 13,
    this.hPadding = 20,
    this.hMargin = 20,
    this.radius = 15,
    this.color,
    this.vMargin = 6,
    this.width,
  }) : super(key: key);
  final Widget child;
  final double vPadding;
  final double hPadding;
  final double hMargin;
  final double vMargin;
  final double radius;
  final Color? color;
  final double? width;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: width ?? size.width,
      padding: EdgeInsets.symmetric(vertical: vPadding, horizontal: hPadding),
      margin: EdgeInsets.symmetric(horizontal: hMargin, vertical: vMargin),
      decoration: BoxDecoration(
        color: Color.fromARGB(52, 206, 206, 206),
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [AppShadow.card],
      ),
      child: child,
    );
  }
}
