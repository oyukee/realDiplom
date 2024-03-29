import 'dart:io';

import 'package:flutter/material.dart';
import 'package:together_app/model/Product.dart';
import 'package:together_app/utils/globals.dart';

import '../../model/ProdModel.dart';


class ProductImages extends StatefulWidget {
  const ProductImages(this.product);

  final ProductModel product;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 238,
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: widget.product.productID.toString(),
              child: //Image.asset(widget.product.imageUrl!),
              Image.file(
                File(widget.product.imageUrl!),
              )
            ),
          ),
        ),
        // SizedBox(height: 20),
      /*  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(1,//widget.product.images.length,
                (index) => buildSmallProductPreview(index)),
          ],
        )*/

      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(8),
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: yellowColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: Image.asset(widget.product.imageUrl!),
      ),
    );
  }
}
