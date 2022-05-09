import 'package:flutter/material.dart';
import 'package:together_app/components/default_button.dart';
import 'package:together_app/model/OrderModel.dart';
import 'package:together_app/model/Product.dart';
import 'package:together_app/size_config.dart';
import 'package:together_app/templates/popUp.dart';
import '../../model/Cart.dart';
import '../../utils/api.dart';
import '../../utils/globals.dart';
import '../../model/ProdModel.dart';
import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatefulWidget {
  final ProductModel product;
  const Body(this.product);
  @override
  _Body createState() => _Body();
}
class _Body extends State<Body> {

/*
class Body extends StatelessWidget {
  final ProductModel product;

  const Body(this.product);
*/

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return ListView(
      children: [
        ProductImages(widget.product),
        Center(
          child: Text(
            "\$${widget.product.discount}",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFFFF4848),
            ),
          ),
        ),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(widget.product
                  //, pressOnSeeMore: () {}
                  ),
              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    //ColorDots(ProductModel: product),
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                          padding: EdgeInsets.only(
                            left: screenWidth * 0.15,
                            right: screenWidth * 0.15,
                            bottom: 40,
                            top: 15,
                          ),
                          child: Center(
                            child: Row(
                              children: [
                              SizedBox(
                              width: 120,
                              height: 56,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  primary: Colors.white,
                                  backgroundColor: yellowColor,
                                ),
                                onPressed: (){
                                  addToCart();
                                  },
                                child: Text(
                                  "Сагсанд нэмэх",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                              height: 56),
                                SizedBox(
                                  width: 120,
                                  height: 56,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      shape:
                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                      primary: Colors.white,
                                      backgroundColor: yellowColor,
                                    ),
                                    onPressed: (){  createOrder();},
                                    child: Text(
                                      "Захиалах",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void createOrder() {
     OrderModel order = new OrderModel();
     order.userId = userId;
     order.productID =widget.product.productID;
     order.discount = widget.product.discount;
     order.quantity = 1;
     order.grandTotal = widget.product.discount;

    APIService apiService = new APIService();
    apiService.createOrder(order).then((value) {
      if (value != null && value == true) {
        try {
          informationPopup(context, "Захиалга", "Амжилттай захиалгдлаа.");
        } catch (e) {
          print("categoryList aldaa $e");
        }
      } else {
        serverErrorPopup(context, "empty value");
      }
    });
  }

  void addToCart() {
    OrderModel order = new OrderModel();
    order.productID =widget.product.productID;
    APIService apiService = new APIService();
    apiService.addToCart(order).then((value) {
      if (value != null && value == true) {
        try {
          informationPopup(context, "Сагс", "Амжилттай нэмэгдлээ.");
        } catch (e) {
          print("categoryList aldaa $e");
        }
      } else {
        serverErrorPopup(context, "empty value");
      }
    });
  }
}
