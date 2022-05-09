//import 'package:TOMO/model/AdditionalService.dart';
//import 'package:TOMO/model/NewsList.dart';
//import 'package:TOMO/screens/NewsDetailScreen.dart';
//import 'package:TOMO/templates/OrderAppBar.dart' as orderAppBar;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:together_app/templates/popUp.dart';
import 'package:together_app/utils/Func.dart';
//import 'package:TOMO/utils/api.dart';
import 'package:together_app/utils/globals.dart' as globals;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

//import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../model/UserList.dart';
import '../utils/api.dart';
import 'ProdDetailScreen.dart';

//import 'NavigationMenu.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> mainDrawerKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    readHomeData();
    super.initState();
  }

  late UserListResponse userInfo;

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     key: mainDrawerKey,
  //     //drawer: NavigationMenuState(),
  //     body: AnnotatedRegion<SystemUiOverlayStyle>(
  //       value: SchedulerBinding.instance?.window.platformBrightness ==
  //               Brightness.dark
  //           ? SystemUiOverlayStyle.dark.copyWith(
  //               statusBarColor: Colors.transparent,
  //             )
  //           : SystemUiOverlayStyle.light.copyWith(
  //               statusBarColor: Colors.transparent,
  //             ),
  //       child: ModalProgressHUD(
  //         inAsyncCall: globals.showProgress,
  //         //opacity: 0.5,
  //         progressIndicator: CircularProgressIndicator(),
  //         child: Container(
  //           child: SingleChildScrollView(
  //             child: Column(
  //               children: [
  //                 //AppBar
  //                 //orderAppBar.draw(context, mainDrawerKey),
  //                 SizedBox(
  //                   height: 10,
  //                 ),
  //
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.accessibility),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on),
            SizedBox(width: 10 / 2),
            Text(
              "15/2 Ulaanbaatar",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        padding:  EdgeInsets.all(5),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Explore",
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontWeight: FontWeight.w500, color: Colors.black),
            ),
            const Text(
              "best Outfits for you",
              style: TextStyle(fontSize: 18),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical:5),
              //child: SearchForm(),
            ),
           //const Categories(),
            //const NewArrivalProducts(),
            //const PopularProducts(),
          ],
        ),
      ),
    );
  }

  buildNewsList() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9 - 130,
      width: MediaQuery.of(context).size.width * 0.9,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
          itemCount: (userInfo.list.length),
          itemBuilder: (BuildContext, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProdDetailScreen(
                              userInfo.list[index].id)),
                    );
                    //Navigator.of(context)
                    //    .push(_orderDetailsScreenRoute());
                  },
                  child: Text(
                    Func.toStr(userInfo.list[index].name),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 20,
                        color: globals.blueColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  Func.toStr(userInfo.list[index].email),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 12,
                    color: globals.grayColor,
                  ),
                ),
                // actionLocation, actionActualDate
                SizedBox(
                  height: 15,
                ),

                Divider(),
              ],
            );
          }),
    );
  }

  readHomeData() {
    try {
      setState(() {
        globals.showProgress = true;
      });

      APIService apiService = new APIService();
      apiService.userList(0).then((value) {
        if (value != null) {

              try {
                setState(() {
                  userInfo = value;
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
