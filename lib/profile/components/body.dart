import 'package:flutter/material.dart';
import 'package:together_app/screens/OrderScreen.dart';

import '../../screens/ProdDetailScreen.dart';
import '../../screens/ProdListScreen.dart';
import '../../splash/splash_screen.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "Хаяг байршил",
            icon: "assets/icons/Location point.svg",
            press: () => {},
          ),
          ProfileMenu(
            text: "Төлбөр төлөх",
            icon: "assets/icons/Cash.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Захиалга",
            icon: "assets/icons/list-check.svg",
            press: () { Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrderScreen()),
            );},
          ),
          ProfileMenu(
            text: "Дуртай",
            icon: "assets/icons/heart.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Бараа нэмэх",
            icon: "assets/icons/shopping-cart.svg",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProdListScreen()),
              );
            },
          ),
          // ProfileMenu(
          //   text: "Тохиргоо",
          //   icon: "assets/icons/Settings.svg",
          //   press: () {},
          // ),
          ProfileMenu(
            text: "Гарах",
            icon: "assets/icons/Log out.svg",
            press: () {Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SplashScreen()),
            );},
          ),
        ],
      ),
    );
  }
}
