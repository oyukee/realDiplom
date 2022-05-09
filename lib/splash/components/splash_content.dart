import 'package:flutter/material.dart';
import 'package:together_app/utils/globals.dart';

import '../../../size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.image,
  }) : super(key: key);
  final String? text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Text(
          "Хамтдаа",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(36),
            color: yellowColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          text!,
          textAlign: TextAlign.center,
        ),
        Spacer(flex: 2),
        Image.asset(
          image!,
          height: getProportionateScreenHeight(285),
          width: getProportionateScreenWidth(255),
        ),
      ],
    );
  }
}
