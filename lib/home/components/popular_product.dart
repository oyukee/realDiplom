import 'package:flutter/material.dart';
import 'package:together_app/components/product_card.dart';
import 'package:together_app/model/Product.dart';

import '../../../size_config.dart';
import '../../model/ProdModel.dart';
import '../../templates/popUp.dart';
import '../../utils/api.dart';
import 'section_title.dart';

class PopularProducts extends StatefulWidget {
  const PopularProducts();

  @override
  _PopularProducts createState() => _PopularProducts();
}

class _PopularProducts extends State<PopularProducts> {
  @override
  void initState() {
    super.initState();
    prodLists();
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(title: "Санал болгох", press: () {}),
        ),
        SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                prodList.list.length,
                (index) {
                  if (prodList.list.isNotEmpty)
                    return ProductCard(prodList.list[index]);

                  return SizedBox
                      .shrink(); // here by default width and height is 0
                },
              ),
              SizedBox(width: 20),
            ],
          ),
        )
      ],
    );
  }

  ProductListResponse prodList = new ProductListResponse(list: []);

  void prodLists() {
    APIService apiService = new APIService();
    apiService.prodList(0).then((value) {
      if (value != null) {
        try {
          setState(() {
            prodList = value;
          });
        } catch (e) {
          print("categoryList aldaa $e");
        }
      } else {
        serverErrorPopup(context, "empty value");
      }
    });
  }
}
