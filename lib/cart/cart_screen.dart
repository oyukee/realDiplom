import 'package:flutter/material.dart';
import 'package:together_app/cart/components/cart_card.dart';
import '../model/ProdModel.dart';
import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  
  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(

      title: Column(
        children: [
          Text(
            "Таны сагс",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "Үнэ",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
