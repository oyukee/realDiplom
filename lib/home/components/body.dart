import 'package:flutter/material.dart';
import 'package:together_app/home/components/search_field.dart';

import '../../../size_config.dart';
import 'discount_banner.dart';
import 'hamtdaaBar.dart';
import 'popular_product.dart';
import 'special_offers.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(

        child: Container(
          width: screen.width,
          child: Column(
            children: [
              HamtdaaBar(),
              SizedBox(height: 20),
              SearchField(),
              DiscountBanner(),
              SpecialOffers(),
              SizedBox(height: 30),
              PopularProducts(),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
