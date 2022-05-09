import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:together_app/details/details_screen.dart';
import 'package:together_app/utils/globals.dart';

import '../model/ProdModel.dart';

class ProductCard extends StatefulWidget {
  final ProductModel _prod;

  const ProductCard(this._prod);

  @override
  _ProductCard createState() => _ProductCard();
}

class _ProductCard extends State<ProductCard> {
  final GlobalKey<ScaffoldState> mainDrawerKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

/*  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
  }) : super(key: key);*/

  final double width=140, aspectRetio = 1.02;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: SizedBox(
        width: width,
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            DetailsScreen.routeName,
            arguments: ProductDetailsArguments(widget._prod),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.02,
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: grayColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Hero(
                    tag: widget._prod.productID.toString(),
                    child:
                    Image.file(
                      File(widget._prod.imageUrl!),
                    )
                    //Image.asset(widget._prod.imageUrl!),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget._prod.prodcutTitle!,
                style: TextStyle(color: Colors.black),
                maxLines: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${widget._prod.discount}",
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
                        color: widget._prod.isFavourite
                            ? yellowColor.withOpacity(0.15)
                            : grayColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/Heart Icon_2.svg",
                        color: widget._prod.isFavourite
                            ? Color(0xFFFF4848)
                            : Color(0xFFDBDEE4),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "\$${widget._prod.productPrice}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: yellowColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
