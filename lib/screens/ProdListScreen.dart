//import 'package:TOMO/model/AdditionalService.dart';
//import 'package:TOMO/model/NewsList.dart';
//import 'package:TOMO/screens/NewsDetailScreen.dart';
//import 'package:TOMO/templates/OrderAppBar.dart' as orderAppBar;
import 'dart:io';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:together_app/model/ProdModel.dart';
import 'package:together_app/templates/popUp.dart';
import 'package:together_app/utils/Func.dart';

//import 'package:TOMO/utils/api.dart';
import 'package:together_app/utils/globals.dart' as globals;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
//import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../components/coustom_bottom_nav_bar.dart';
import '../enums.dart';
import '../model/UserList.dart';
import '../templates/AppMenu.dart';
import '../utils/api.dart';
import 'ProdDetailScreen.dart';

//import 'NavigationMenu.dart';

class ProdListScreen extends StatefulWidget {
  @override
  _ProdListScreen createState() => _ProdListScreen();
}

class _ProdListScreen extends State<ProdListScreen> {
  final GlobalKey<ScaffoldState> mainDrawerKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    readProdData();
    super.initState();
  }

  //late ProductListResponse prodList;
  ProductListResponse prodList = new ProductListResponse(list: []);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SchedulerBinding.instance?.window.platformBrightness ==
                Brightness.dark
            ? SystemUiOverlayStyle.dark.copyWith(
                statusBarColor: Colors.transparent,
              )
            : SystemUiOverlayStyle.light.copyWith(
                statusBarColor: Colors.transparent,
              ),
        child: ModalProgressHUD(
          inAsyncCall: globals.showProgress,
          //opacity: 0.5,
          progressIndicator: CircularProgressIndicator(),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //AppBar
                  //orderAppBar.draw(context, mainDrawerKey),
                  SizedBox(
                    height: 10,
                  ),
                  insertProdButton(),
                  SizedBox(
                    height: 10,
                  ),
                  buildProdList(),
                  buildIconNavBar(context),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }

  buildProdList() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9 - 130,
      width: MediaQuery.of(context).size.width * 0.9,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: ListView.builder(
          itemCount: (prodList.list.length),
          itemBuilder: (BuildContext, index) {
            return Row(
              children: [
                SizedBox(
                  height: 100,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProdDetailScreen(
                                prodList.list[index].productID)),
                      );
                      //Navigator.of(context)
                      //    .push(_orderDetailsScreenRoute());
                    },
                    child: (File(prodList.list[index].imageUrl!).existsSync()
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
                          ))),

                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProdDetailScreen(
                                  prodList.list[index].productID)),
                        );
                        //Navigator.of(context)
                        //    .push(_orderDetailsScreenRoute());
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9 - 110,
                        child: Text(
                          prodList.list[index].prodcutTitle!,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 20,
                              color: globals.blueColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9 - 110,
                      child: Text(
                        prodList.list[index].summary!,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: globals.grayColor,
                        ),
                      ),
                    ),
                    // actionLocation, actionActualDate
                    SizedBox(
                      height: 15,
                    ),
                    Divider(),
                  ],
                ),
              ],
            );
          }),
    );
  }

  Widget insertProdButton() {
    return Center(
        child: Container(
      padding: EdgeInsets.symmetric(vertical: 0),
      width: MediaQuery.of(context).size.width * 0.8,
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(globals.yellowColor),
            padding: MaterialStateProperty.all(EdgeInsets.only(left:5,top:0,right:5, bottom:0)),
          ),
          child: Text(
            'Бүтээгдэхүүн нэмэх',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: globals.whiteColor,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProdDetailScreen(0)),
            );
          }),
    ));
  }

  readProdData() {
    try {
      setState(() {
        globals.showProgress = true;
      });

      APIService apiService = new APIService();
      apiService.prodList(0).then((value) {
        if (value != null) {
          try {
            setState(() {
              prodList = value;
            });
          } catch (e) {
            print("user aldaa $e");
          }
        } else {
          serverErrorPopup(context, "Aldaa garlaa");
        }
      });
    } catch (e) {
      print(e.toString());
      serverErrorPopup(context, globals.msg_HTTP);
    } finally {
      setState(() {
        globals.showProgress = false;
      });
    }
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
                      color: globals.blueColor,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
