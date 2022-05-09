import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../components/coustom_bottom_nav_bar.dart';
import '../../details/details_screen.dart';
import '../../enums.dart';
import '../../model/ProdModel.dart';
import '../../templates/popUp.dart';
import '../../utils/Func.dart';
import '../../utils/api.dart';
import '../../utils/globals.dart';
import 'section_title.dart';

class ProductList extends StatefulWidget {
  final int? _catId;

  const ProductList(this._catId);

  @override
  _ProductList createState() => _ProductList();
}

class _ProductList extends State<ProductList> {
  @override
  void initState() {
    super.initState();
    prodLists();
    setState(() {});
  }

  final double width = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      //drawer: NavigationMenuState(),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SchedulerBinding.instance?.window.platformBrightness ==
                  Brightness.dark
              ? SystemUiOverlayStyle.dark.copyWith(
                  statusBarColor: Colors.transparent,
                )
              : SystemUiOverlayStyle.light.copyWith(
                  statusBarColor: Colors.transparent,
                ),
          child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height  * 0.9 - 10,
            child: Column(
              children: [
                SizedBox(height: 20),
                backButton(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SectionTitle(title: "Санал болгох", press: () {}),
                ),
                SizedBox(height: 10),
                Flexible(
                  //height: MediaQuery.of(context).size.height * 0.9 -150,
                  child: SingleChildScrollView(
                    child: GridView.count(
                      crossAxisCount: 2,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                        (prodList.list.isEmpty ? 0 : prodList.list.length),
                        (index) {
                          return Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                context,
                                DetailsScreen.routeName,
                                arguments: ProductDetailsArguments(
                                    prodList.list[index]),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: grayColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Hero(
                                        tag: prodList.list[index].productID
                                            .toString(),
                                        child:  (File(prodList.list[index].imageUrl!).existsSync()
                                            ? Image.file(
                                          File(prodList.list[index].imageUrl!),
                                          width: 85,
                                          height: 85,
                                          fit: BoxFit.cover,
                                        )
                                            : Image.asset(
                                          "assets/images/noimageavailable.jpg",
                                          width: 85,
                                          height: 85,
                                          fit: BoxFit.cover,
                                        ))
                                        //Image.asset(prodList.list[index].imageUrl!),
                                        ),
                                  ),
                                  Text(
                                    prodList.list[index].prodcutTitle!,
                                    style: TextStyle(color: Colors.black),
                                    maxLines: 2,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "\$${prodList.list[index].discount}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFFFF4848),
                                          ),
                                        ),
                                        InkWell(
                                          borderRadius: BorderRadius.circular(50),
                                          onTap: () {},
                                          child: Container(
                                            padding: EdgeInsets.all(8),
                                            height: 28,
                                            width: 28,
                                            decoration: BoxDecoration(
                                              color: prodList
                                                      .list[index].isFavourite
                                                  ? yellowColor.withOpacity(0.15)
                                                  : grayColor.withOpacity(0.1),
                                              shape: BoxShape.circle,
                                            ),
                                            child: SvgPicture.asset(
                                              "assets/icons/Heart Icon_2.svg",
                                              color:
                                                  prodList.list[index].isFavourite
                                                      ? Color(0xFFFF4848)
                                                      : Color(0xFFDBDEE4),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "\$${prodList.list[index].productPrice}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: yellowColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ); // here by default width and height is 0
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }

  ProductListResponse prodList = new ProductListResponse(list: []);

  void prodLists() {
    APIService apiService = new APIService();
    apiService.prodByCategoryList(widget._catId!).then((value) {
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

  Widget backButton() {
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Container(
            padding: const EdgeInsets.fromLTRB(10, 20, 20, 20),
            child: Row(
              children: [
                /* new Image.asset(
                  globals.png_back_btn,
                  width: 8,
                  height: 7,
                ),*/
                SizedBox(
                  width: 5,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Буцах',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
