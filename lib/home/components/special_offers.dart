import 'package:flutter/material.dart';
import 'package:together_app/home/components/product_list.dart';
import 'package:together_app/utils/globals.dart' as globals;
import '../../../size_config.dart';
import '../../model/CategoryModel.dart';
import '../../templates/popUp.dart';
import '../../utils/Func.dart';
import '../../utils/api.dart';
import 'section_title.dart';

class SpecialOffers extends StatefulWidget {
  // final int? _prodId;

  // const SpecialOffers(this._prodId);
  const SpecialOffers();

  @override
  _SpecialOffers createState() => _SpecialOffers();
}

class _SpecialOffers extends State<SpecialOffers> {
  @override
  void initState() {
    super.initState();
    categoryLists();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SectionTitle(
              title: "Бүх ангилал",
              press: () {},
            ),
          ),
          SizedBox(height: 20),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: 500,
                height: 80,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: (categoryList.list.length),
                    itemBuilder: (BuildContext, index) {
                      return SpecialOfferCard(
                        image: (categoryList.list[index].imageUrl == null
                            ? "assets/images/noimageavailable.jpg"
                            : categoryList.list[index].imageUrl!),
                        category: categoryList.list[index].title!,
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProductList(categoryList.list[index].categoryID)),
                          );
                        },
                      );
                    }),
              ))
        ],
      ),
    );
  }

  CategoryListResponse categoryList = new CategoryListResponse(list: []);

  void categoryLists() {
    APIService apiService = new APIService();
    apiService.categoryList().then((value) {
      if (value != null) {
        try {
          setState(() {
            categoryList = value;
            globals.selectedCategoryID = categoryList.list[0].categoryID!;
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

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: 80,
          height: 80,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF343434).withOpacity(0.4),
                        Color(0xFF343434).withOpacity(0.15),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 30,
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "$category\n",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
