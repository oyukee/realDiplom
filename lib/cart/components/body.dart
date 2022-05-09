import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:together_app/model/Cart.dart';

import '../../../size_config.dart';
import '../../model/CartItemModel.dart';
import '../../model/ProdModel.dart';
import '../../templates/popUp.dart';
import '../../utils/api.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<ScaffoldState> mainDrawerKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    readCartList();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ListView.builder(
        itemCount: (cartList.list.isEmpty? 0: cartList.list.length),
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: Key(cartList.list[index].iD.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                cartList.list.removeAt(index);
              });
            },
            background: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xFFFFE6E6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Spacer(),
                  SvgPicture.asset("assets/icons/Trash.svg"),
                ],
              ),
            ),
            child: CartCard(cart: cartList.list[index]),
          ),
        ),
      ),
    );
  }
  CartItemListResponse cartList = new CartItemListResponse(list: []);

  readCartList() {
    APIService apiService = new APIService();
    apiService.cartItemList(0).then((value) {
      if (value != null) {
        try {
          setState(() {
            cartList = value;
          });
        } catch (e) {
          print("cart list deer aldaa $e");
        }
      } else {
        serverErrorPopup(context, "empty value");
      }
    });
  }
}
