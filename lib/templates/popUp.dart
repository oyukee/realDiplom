import 'package:together_app/utils/func.dart';
import 'package:together_app/utils/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

void informationPopup(BuildContext context, String topic, String msg) {
  showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            backgroundColor: globals.whiteColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 2, color: globals.yellowColor)),
                height: 120 + msg.length / 2,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              padding:
                                  EdgeInsets.only(top: 10, left: 10, right: 10),
                              alignment: Alignment.topLeft,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(topic,
                                        style: TextStyle(
                                          color: globals.yellowColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    InkWell(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        child: Icon(
                                          MdiIcons.closeCircle,
                                          color: globals.yellowColor,
                                          size: 20,
                                        )),
                                  ])),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            alignment: Alignment.topLeft,
                            child: Text(msg,
                                style: TextStyle(
                                  color: globals.blackColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                )),
                          ),
                        ]),
                  ),
                ])),
          );
        });
      });
}

void validationErrorPopup(BuildContext context, String msg) {
  showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            backgroundColor: globals.whiteColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 2, color: Colors.yellow)),
                height: 120 + msg.length / 2,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              padding:
                                  EdgeInsets.only(top: 10, left: 10, right: 10),
                              alignment: Alignment.topLeft,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Алдаа",
                                        style: TextStyle(
                                          color: globals.redColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    InkWell(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        child: Icon(
                                          MdiIcons.closeCircle,
                                          color: globals.redColor,
                                          size: 20,
                                        )),
                                  ])),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            alignment: Alignment.topLeft,
                            child: Text(msg,
                                style: TextStyle(
                                  color: globals.blackColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                )),
                          ),
                        ]),
                  ),
                ])),
          );
        });
      });
}

void serverErrorPopup(BuildContext context, String msg) {
  showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            backgroundColor: globals.lightPinkColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 2, color: Colors.red)),
                width: MediaQuery.of(context).size.width,
                height: 152 + Func.toDouble(msg.length),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                height: 30,
                                padding: EdgeInsets.only(top: 10, left: 10),
                                alignment: Alignment.topLeft,
                                child: Text("Алдаа",
                                    style: TextStyle(
                                      color: globals.redColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ))),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Container(
                                  width: 30,
                                  height: 25,
                                  padding: EdgeInsets.only(
                                      top: 8, left: 0, right: 15),
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                    MdiIcons.closeCircle,
                                    color: globals.redColor,
                                    size: 20,
                                  )),
                            ),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 100 + Func.toDouble(msg.length),
                              padding: EdgeInsets.only(left: 10),
                              alignment: Alignment.topLeft,
                              child: Text(msg,
                                  style: TextStyle(
                                    color: globals.blackColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  )),
                            ),
                            Container(
                              child: Image.asset(
                                globals.png_server_error,
                                height: 100 + Func.toDouble(msg.length),
                                width: 100,
                              ),
                            ),
                          ]),
                    ])),
          );
        });
      });
}

Future<void> _showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('AlertDialog Title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('This is a demo alert dialog.'),
              Text('Would you like to approve of this message?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Approve'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
