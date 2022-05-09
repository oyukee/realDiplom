import 'package:flutter/material.dart';
import 'package:together_app/utils/globals.dart';

import 'otp_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              Text(
                "Баталгаажуулах код",style: TextStyle(color: yellowColor,fontSize: 20)
              ),
              Text("Таны утсанд мессэжээр ирсэн 4 оронтой \nбаталгаажуулах кодыг оруулна уу."),
              buildTimer(),
              OtpForm(),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // OTP code resend
                },
                child: Text(
                  "Дахин код авах",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Кодын хүчинтэй хугацаа:"),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0.0),
          duration: Duration(seconds: 30),
          builder: (_, dynamic value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(color: yellowColor),
          ),
        ),
      ],
    );
  }
}
