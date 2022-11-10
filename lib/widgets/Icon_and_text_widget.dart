import 'package:flutter/material.dart';
import 'package:food_users/widgets/small_text.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;

  final Color iconColor;
  IconAndTextWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: MediaQuery.of(context).size.width / 20,
        ),
        const SizedBox(
          width: 2,
        ),
        smallText(
          text: text,
        ),
      ],
    );
  }
}
