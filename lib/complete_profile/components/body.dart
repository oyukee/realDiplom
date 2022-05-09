import 'package:flutter/material.dart';
import 'package:together_app/utils/globals.dart';


import 'complete_profile_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10),
                Text("Хувийн мэдээлэл", style: headingStyle),
                Text(
                  "Дэлгэрэнгүй мэдээллийг бөглөж эсвэл олон нийтийн мэдээллийн хэрэгслээр үргэлжлүүлээрэй",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                CompleteProfileForm(),
                SizedBox(height: 30),
                Text(
                  "Үргэлжлүүлснээр та манай нөхцөл, болзлыг зөвшөөрч байгаагаа баталгаажуулна",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
