import 'package:flutter/material.dart';
import 'package:together_app/sign_up/sign_up_screen.dart';
import 'package:together_app/utils/globals.dart';


class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Та бүртгэлтэй юу? ",
          style: TextStyle(fontSize: 16),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
          child: Text(
            "Бүртгүүлэх",
            style: TextStyle(
                fontSize: 16,
                color: yellowColor),
          ),
        ),
      ],
    );
  }
}
