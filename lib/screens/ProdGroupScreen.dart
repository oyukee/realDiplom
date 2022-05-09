//import 'package:TOMO/model/AdditionalService.dart';
//import 'package:TOMO/model/NewsList.dart';
//import 'package:TOMO/screens/NewsDetailScreen.dart';
//import 'package:TOMO/templates/OrderAppBar.dart' as orderAppBar;
import 'dart:io';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:together_app/model/ProdGroupModel.dart';
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
import '../home/components/hamtdaaBar.dart';
import '../model/UserList.dart';
import '../templates/AppMenu.dart';
import '../utils/api.dart';
import 'GroupUsersScreen.dart';
import 'ProdDetailScreen.dart';

//import 'NavigationMenu.dart';

class ProdGroupScreen extends StatefulWidget {
  final int? _prodId;

  const ProdGroupScreen(this._prodId);

  @override
  _ProdGroupScreen createState() => _ProdGroupScreen();
}

class _ProdGroupScreen extends State<ProdGroupScreen> {
  final GlobalKey<ScaffoldState> mainDrawerKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    readProdData();
    super.initState();
  }

  //late ProductListResponse prodList;
  ProdGroupResponse prodList = new ProdGroupResponse(list: []);

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
                  HamtdaaBar(),
                  SizedBox(
                    height: 10,
                  ),
                  buildProdList(),
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
            if (index == 0) {
              return Container(
                width: MediaQuery.of(context).size.width -30,
                height: 50,
                decoration: BoxDecoration(
                    color: globals.lightGrayColor,
                    borderRadius: BorderRadius.circular(6)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        "Захиалгын дугаар",
                        textAlign: TextAlign.left,
                        softWrap: true,
                        style: TextStyle(
                            fontSize: 16,
                            color: globals.yellowColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Захиалгын тоо",
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16,
                            color: globals.yellowColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              );
            }
            index -= 1;
            return Row(
              children: [
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GroupUsersScreen(
                              Func.toInt(prodList.list[index].orderGroupID!))),
                    );
                    //Navigator.of(context)
                    //    .push(_orderDetailsScreenRoute());
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    padding: EdgeInsets.only(left: 20),
                    child:
                    Text(
                      "№:" + Func.toStr(prodList.list[index].orderGroupID!),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                          color: globals.blackColor ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    "Захиалгын тоо: " +
                        Func.toStr(prodList.list[index].orderQuantity!),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 16,
                        color: globals.blackColor, ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  readProdData() {
    try {
      setState(() {
        globals.showProgress = true;
      });

      APIService apiService = new APIService();
      apiService.prodGroupList(widget._prodId!).then((value) {
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
}
