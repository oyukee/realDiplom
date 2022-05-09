import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:together_app/cart/cart_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'icon_btn_with_counter.dart';
import 'package:together_app/utils/globals.dart';

class HamtdaaBar extends StatelessWidget {


  const HamtdaaBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

  return Container(
    color: yellowColor,
    padding:EdgeInsets.all(16.0),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Text('Hamtdaa',  textAlign: TextAlign.center, style: TextStyle(fontFamily: 'WaterBrush-Regular', fontSize: 34)),
      ),
        IconBtnWithCounter(
          svgSrc: "assets/icons/Cart Icon.svg",
          press: ()  => Navigator.pushNamed(context, CartScreen.routeName),
        ),
    ],
    ),
    );
  }
}


//         appBar: AppBar(
//           title: Text("Flutter AppBar Example"),
//           actions: [
//             IconButton(
//               icon: Icon(Icons.search),
//               onPressed: () {
//               },
//             ),
//             IconButton(
//               icon: Icon(Icons.more_vert,),
//               onPressed: () {
//               },
//             )
//           ],
//           actionsIconTheme: IconThemeData(size: 32,),
// ),


