import 'package:flutter/material.dart';

class smallText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;

  smallText({
    Key? key,
    this.color = const Color(0xFFccc7c5),
    required this.text,
    this.size = 0,
    this.height = 1.2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          height: height, color: color, fontSize: size == 0 ? 14 : size),
    );
  }
}
