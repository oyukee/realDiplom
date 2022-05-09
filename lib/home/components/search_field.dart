import 'package:flutter/material.dart';
import 'package:together_app/utils/globals.dart';


class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.9,
      decoration: BoxDecoration(
        color: grayColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: (value) => print(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Хайх",
            prefixIcon: Icon(Icons.search)),
      ),
    );
  }
}
