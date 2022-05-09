import 'dart:io';

import 'package:flutter/material.dart';
import 'package:together_app/utils/globals.dart';
import '../../model/ProdModel.dart';
import 'package:together_app/model/CartItemModel.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final CartItemModel cart;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.file(File(cart.imageUrl!)),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 155,
              child: Text(
                cart.content!,
                style: TextStyle(color: Colors.black, fontSize: 16),
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
              ),
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: "\$${cart.price}",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: yellowColor),
                children: [
                  TextSpan(
                      text: " x${1}", //cart.quantity
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText1),
                ],
              ),
            )
          ],
        )
      ],
    );
  }


}
