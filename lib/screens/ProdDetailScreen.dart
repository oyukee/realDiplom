import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:together_app/model/ProdModel.dart';
import 'package:together_app/screens/ProdGroupScreen.dart';
import 'package:together_app/screens/ProdListScreen.dart';
import 'package:together_app/templates/popUp.dart';
import 'package:together_app/utils/Func.dart';

//import 'package:together_app/utils/api.dart';
import 'package:together_app/utils/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
//import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../model/CategoryModel.dart';
import '../utils/api.dart';

//import 'NavigationMenu.dart';

class ProdDetailScreen extends StatefulWidget {
  final int? _prodId;

  const ProdDetailScreen(this._prodId);

  @override
  _ProdDetailScreen createState() => _ProdDetailScreen();
}

class _ProdDetailScreen extends State<ProdDetailScreen> {
  final GlobalKey<ScaffoldState> mainDrawerKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _ctrProdTitle = TextEditingController();
  final TextEditingController _ctrProdSummary = TextEditingController();
  final TextEditingController _ctrProdPrice = TextEditingController();
  final TextEditingController _ctrDiscount = TextEditingController();
  final TextEditingController _ctrQuantity = TextEditingController();
  final TextEditingController _ctrGroupQty = TextEditingController();

  //final TextEditingController _ctrCurrentOrderQty =  TextEditingController();
  final TextEditingController _ctrContent = TextEditingController();
  final TextEditingController _ctrSerialNo = TextEditingController();
  final TextEditingController _ctrImageUrl = TextEditingController();

  String _selectedCategory = "";
  bool isImageSelected = false;

  final String _strProdTitle = "";
  final String _strProdSummary = "";
  final String _strProdPrice = "";
  final String _strDiscount = "";
  final String _strQuantity = "";
  final String _strGroupQty = "";

  //String _strCurrentOrderQty = "";
  final String _strContent = "";
  final String _strSerialNo = "";
  String _strImageUrl = "";

  String _errorMessage = "";
  bool validationPassed = true;

  @override
  void initState() {
    super.initState();

    fillDropDownLists();
    readData();
    fillControls();
    /* _ctrProdPrice.addListener(() {
      validatePrice();
    });
    _ctrDiscount.addListener(() {
      validateScore();
    });
    _ctrQuantity.addListener(() {
      validateScore();
    });
    _ctrGroupQty.addListener(() {
      validateScore();
    });*/

    setState(() {});
  }

  CategoryListResponse categoryList = CategoryListResponse(list: []);
  ProductListResponse prodInfo = ProductListResponse(list: []);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      key: mainDrawerKey,
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
        child: ModalProgressHUD(
          inAsyncCall: globals.showProgress,
          // _showSpinner,
          opacity: 0.5,
          progressIndicator: CircularProgressIndicator(),
          child: Column(children: [
            //AppBar
            //orderAppBar.draw(context, mainDrawerKey),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height -
                    70 -
                    MediaQuery.of(context).padding.bottom -
                    MediaQuery.of(context).padding.top,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        //back bt
                        backButton(),
                        buildCategoryDropDown(),
                        SizedBox(
                          height: 5,
                        ),
                        buildProdTitle(),
                        SizedBox(
                          height: 5,
                        ),
                        buildProdSummary(),
                        SizedBox(
                          height: 5,
                        ),
                        buildProdPrice(),
                        SizedBox(
                          height: 5,
                        ),
                        buildDiscount(),
                        SizedBox(
                          height: 5,
                        ),
                        buildQuantity(),
                        SizedBox(
                          height: 5,
                        ),
                        buildGroupQty(),
                        SizedBox(
                          height: 5,
                        ),
                        buildContent(),
                        SizedBox(
                          height: 5,
                        ),
                        buildSerialNo(),
                        SizedBox(
                          height: 5,
                        ),
                        //buildImageUrl(),

                        buildImageUrlPicker(isImageSelected, _strImageUrl,
                            (file) {
                          _strImageUrl = file.path;
                          _ctrImageUrl.text = file.path;
                          isImageSelected = true;
                        }),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  saveButton(),
                  groupDetailButton(),
                ]),
          ]),
        ),
      ),
    );
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

  void fillDropDownLists() {
    APIService apiService = new APIService();
    apiService.categoryList().then((value) {
      if (value != null) {
        try {
          setState(() {
            categoryList = value;
            _selectedCategory = Func.toStr(categoryList.list[0].categoryID!);
          });
        } catch (e) {
          print("categoryList aldaa $e");
        }
      } else {
        serverErrorPopup(context, "empty value");
      }
    });
  }

  readData() {
    try {
      setState(() {
        globals.showProgress = true;
      });

      APIService apiService = new APIService();
      apiService.prodList(widget._prodId!).then((value) {
        if (value != null) {
          try {
            setState(() {
              prodInfo = value;
              fillControls();
            });
            setState(() {});
          } catch (e) {
            print("prodInfo aldaa $e");
          }
        } else {
          serverErrorPopup(context, "empty value");
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
    ;
  }

  Container buildProdTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width - 30,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: globals.lightGrayColor,
          borderRadius: BorderRadius.circular(6)),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        TextFormField(
          keyboardType: TextInputType.text,
          inputFormatters: [],
          decoration: InputDecoration(
              border: null,
              labelText: 'Бүтээгдэхүүн нэр',
              hintStyle: const TextStyle(color: globals.hintGrayColor),
              errorText: (_strProdTitle.isNotEmpty ? _strProdTitle : null)),
          controller: _ctrProdTitle,
        ),
      ]),
    );
  }

  Container buildProdSummary() {
    return Container(
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width - 30,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: globals.lightGrayColor,
          borderRadius: BorderRadius.circular(6)),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        TextFormField(
          decoration: InputDecoration(
              border: null,
              labelText: 'Бүтээгдэхүүний мэдээлэл',
              hintStyle: TextStyle(color: globals.hintGrayColor),
              errorText: (_strProdSummary.isNotEmpty ? _strProdSummary : null)),
          controller: _ctrProdSummary,
        ),
      ]),
    );
  }

  Container buildProdPrice() {
    return Container(
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width - 30,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: globals.lightGrayColor,
          borderRadius: BorderRadius.circular(6)),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              border: null,
              labelText: 'Үнэ',
              hintStyle: TextStyle(color: globals.hintGrayColor),
              errorText: (_strProdPrice.isNotEmpty ? _strProdPrice : null)),
          controller: _ctrProdPrice,
          onChanged: (val) {
            //_ctrProdPrice
          },
        ),
      ]),
    );
  }

  Container buildDiscount() {
    return Container(
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width - 30,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: globals.lightGrayColor,
          borderRadius: BorderRadius.circular(6)),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              border: null,
              labelText: 'Хямдрах үнэ',
              hintStyle: TextStyle(color: globals.hintGrayColor),
              errorText: (_strDiscount.isNotEmpty ? _strDiscount : null)),
          controller: _ctrDiscount,
        ),
      ]),
    );
  }

  Container buildQuantity() {
    return Container(
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width - 30,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: globals.lightGrayColor,
          borderRadius: BorderRadius.circular(6)),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              border: null,
              labelText: 'Агуулах дах тоо',
              hintStyle: TextStyle(color: globals.hintGrayColor),
              errorText: (_strQuantity.isNotEmpty ? _strQuantity : null)),
          controller: _ctrQuantity,
        ),
      ]),
    );
  }

  Container buildGroupQty() {
    return Container(
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width - 30,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: globals.lightGrayColor,
          borderRadius: BorderRadius.circular(6)),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              border: null,
              labelText: 'Хамтдаа авах тоо',
              hintStyle: TextStyle(color: globals.hintGrayColor),
              errorText: (_strGroupQty.isNotEmpty ? _strGroupQty : null)),
          controller: _ctrGroupQty,
        ),
      ]),
    );
  }

  Container buildContent() {
    return Container(
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width - 30,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: globals.lightGrayColor,
          borderRadius: BorderRadius.circular(6)),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        TextFormField(
          decoration: InputDecoration(
              border: null,
              labelText: 'Бүтээгдэхүүний үзүүлэлт',
              hintStyle: TextStyle(color: globals.hintGrayColor),
              errorText: (_strContent.isNotEmpty ? _strContent : null)),
          controller: _ctrContent,
        ),
      ]),
    );
  }

  Container buildSerialNo() {
    return Container(
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width - 30,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: globals.lightGrayColor,
          borderRadius: BorderRadius.circular(6)),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        TextFormField(
          decoration: InputDecoration(
              border: null,
              labelText: 'Сериал, марк',
              hintStyle: TextStyle(color: globals.hintGrayColor),
              errorText: (_strSerialNo.isNotEmpty ? _strSerialNo : null)),
          controller: _ctrSerialNo,
        ),
      ]),
    );
  }

  Container buildImageUrl() {
    return Container(
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width - 30,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: globals.lightGrayColor,
          borderRadius: BorderRadius.circular(6)),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        TextFormField(
          decoration: InputDecoration(
              border: null,
              labelText: 'Зургийн зам',
              hintStyle: TextStyle(color: globals.hintGrayColor),
              errorText: (_strImageUrl.isNotEmpty ? _strImageUrl : null)),
          controller: _ctrImageUrl,
        ),
      ]),
    );
  }

  Widget buildImageUrlPicker(
      bool isFileSelected, String fileName, Function onFilePicket) {
    Future<XFile?> _imageFile;
    ImagePicker _picker = ImagePicker();
    return Center(
      child: Container(
        width: 155,
        height: 155,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              fileName.isNotEmpty
                  ? isFileSelected
                      ? Image.file(
                          File(fileName),
                          height: 120,
                          width: 120,
                        )
                      : SizedBox(
                          child: Image.asset(
                            "assets/images/noimageavailable.jpg",
                            width: 120,
                            height: 120,
                            fit: BoxFit.scaleDown,
                          ),
                        )
                  : SizedBox(
                      child: Image.asset(
                        "assets/images/instagram.png",
                        width: 120,
                        height: 120,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(
                    height: 35,
                    width: 35,
                    child: IconButton(
                      padding: const EdgeInsets.all(0),
                      icon: const Icon(
                        Icons.image,
                        size: 35,
                      ),
                      onPressed: () {
                        _imageFile =
                            _picker.pickImage(source: ImageSource.gallery);
                        _imageFile.then((file) async {
                          onFilePicket(file);
                        });
                      },
                    )),
                SizedBox(
                    height: 35,
                    width: 35,
                    child: IconButton(
                      padding: const EdgeInsets.all(0),
                      icon: const Icon(
                        Icons.camera,
                        size: 35,
                      ),
                      onPressed: () {
                        _imageFile =
                            _picker.pickImage(source: ImageSource.camera);
                        _imageFile.then((file) async {
                          onFilePicket(file);
                        });
                      },
                    ))
              ]),
            ]),
      ),
    );
  }

  Widget buildCategoryDropDown() {
    return Container(
      height: 60,
      padding: EdgeInsets.only(left: 20, right: 5, top: 0, bottom: 0),
      width: MediaQuery.of(context).size.width - 60,
      child: InputDecorator(
          decoration: const InputDecoration(
              fillColor: globals.lightGrayColor,
              filled: true,
              labelText: 'Категори',
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 0.0),
              )),
          child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                  highlightColor: globals.lightGrayColor,
                  buttonColor: globals.lightGrayColor,
                  alignedDropdown: true,
                  child: new DropdownButton(
                      dropdownColor: globals.lightGrayColor,
                      value: _selectedCategory,
                      isExpanded: true,
                      items: categoryList.list
                          .map((CategoryModel item) => DropdownMenuItem<String>(
                              child: Text(item.title!),
                              value: Func.toStr(item.categoryID!)))
                          .toList(),
                      onChanged: (newValue) {
                        if (mounted) {
                          if (categoryList.list.length == 0)
                            setState(() {
                              _selectedCategory = "";
                            });
                          else
                            setState(() {
                              _selectedCategory = Func.toStr(newValue!);
                            });
                        }
                      })))),
    );
  }

  Widget groupDetailButton() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        padding: EdgeInsets.symmetric(vertical: 15),
        child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(globals.yellowColor),
              padding: MaterialStateProperty.all(
                  EdgeInsets.only(left: 1, top: 0, right: 1, bottom: 0)),
            ),
            child: Text(
              'ЗАХИАЛГЫН МЭДЭЭЛЭЛ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: globals.whiteColor,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProdGroupScreen(widget._prodId)),
              );
            }),
      ),
    );
  }

  Widget saveButton() {
    return Center(
        child: Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      width: MediaQuery.of(context).size.width * 0.4,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(globals.yellowColor),
          padding: MaterialStateProperty.all(EdgeInsets.all(5)),
        ),
        child: Text(
          'ХАДГАЛАХ',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: globals.whiteColor,
          ),
        ),
        onPressed: () {
          //validateAndSave();

          validationPassed = formValidation();
          if (!validationPassed) {
            validationErrorPopup(context, _errorMessage);
          } else {
            if (!_formKey.currentState!.validate()) {
              validationErrorPopup(context, "Формын өгөгдөл алдаатай байна");
              return;
            }
            //_submit();

            APIService apiService = new APIService();
            ProductModel prod = new ProductModel();

            if (prodInfo.list.length > 0)
              prod.productID = prodInfo.list[0].productID;
            prod.categoryID = Func.toInt(_selectedCategory);
            prod.prodcutTitle = _ctrProdTitle.text;
            prod.summary = _ctrProdSummary.text;
            prod.productPrice = Func.toDouble(_ctrProdPrice.text);
            prod.discount = Func.toDouble(_ctrDiscount.text);
            prod.quantity = Func.toInt(_ctrQuantity.text);
            prod.groupQty = Func.toInt(_ctrGroupQty.text);
            //prod.currentOrderQty = _ctrCurrentOrderQty.text;
            prod.content = _ctrContent.text;
            prod.serialNo = _ctrSerialNo.text;
            prod.imageUrl = _ctrImageUrl.text;

            try {
              setState(() {
                globals.showProgress = true;
              });
              apiService
                  .saveProdInfo(prod, (widget._prodId == 0 ? false : true))
                  .then((value) {
                if (value != null) {
                  if (value) {
                    prodUpdatePopUp();
                  } else {
                    serverErrorPopup(context, globals.msg_HTTP);
                  }
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
            ;
          }
        },
      ),
    ));
  }

  bool formValidation() {
    _errorMessage = "";
    var validationPassed = true;
    if (_selectedCategory == 0) {
      _errorMessage = _errorMessage + "Бүтээгдэхүүний категори сонгоно уу?";
      validationPassed = false;
    }

    if (_ctrProdTitle.text.isEmpty) {
      _errorMessage = _errorMessage + "Бүтээгдэхүүний нэр хоосон байна.";
      validationPassed = false;
    }

    if (_ctrProdSummary.text.isEmpty) {
      _errorMessage = _errorMessage + "Бүтээгдэхүүний мэдээлэл хоосон байна.";
      validationPassed = false;
    }

    if (_ctrProdPrice.text.isEmpty) {
      _errorMessage = _errorMessage + "Үнийн мэдээлэл оруулна уу.";
      validationPassed = false;
    } else {
      bool validNumber = RegExp(r'^\d*\.?\d*$').hasMatch(_ctrProdPrice.text);
      if (!validNumber) {
        _errorMessage = _errorMessage + "\nЗөв үнэ оруулна уу.";
        validationPassed = false;
      }
    }

    if (_ctrDiscount.text.isEmpty) {
      _errorMessage = _errorMessage + "Хямдрах үнийн мэдээлэл оруулна уу.";
      validationPassed = false;
    } else {
      bool validNumber = RegExp(r'^\d*\.?\d*').hasMatch(_ctrDiscount.text);
      if (!validNumber) {
        _errorMessage = _errorMessage + "\nЗөв хямдрах үнэ оруулна уу.";
        validationPassed = false;
      }
    }
    if (_ctrQuantity.text.isEmpty) {
      _errorMessage =
          _errorMessage + "Агуулах дах тоо ширхэгийн мэдээлэл оруулна уу.";
      validationPassed = false;
    } else {
      bool validNumber = RegExp(r'^\d*').hasMatch(_ctrQuantity.text);
      if (!validNumber) {
        _errorMessage =
            _errorMessage + "\nЗөв агуулах дах тоо ширхэг оруулна уу.";
        validationPassed = false;
      }
    }
    if (_ctrGroupQty.text.isEmpty) {
      _errorMessage = _errorMessage + "Хамтдаа авах тоо мэдээлэл оруулна уу.";
      validationPassed = false;
    } else {
      bool validNumber = RegExp(r'^\d*').hasMatch(_ctrGroupQty.text);
      if (!validNumber) {
        _errorMessage =
            _errorMessage + "\nЗөв хамтдаа авах тоо ширхэг оруулна уу.";
        validationPassed = false;
      }
    }
    if (_ctrContent.text.isEmpty) {
      _errorMessage = _errorMessage + "Бүтээгдэхүүний үзүүлэлт хоосон байна.";
      validationPassed = false;
    }

    if (_ctrSerialNo.text.isEmpty) {
      _errorMessage = _errorMessage + "Сериал, марк хоосон байна.";
      validationPassed = false;
    }
    return validationPassed;
  }

  void prodUpdatePopUp() {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              child: Container(
                height: 150,
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                      child: Text(
                        "Бүтээгдэхүүн амжилттай хадгалагдлаа.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: globals.blackColor,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 50,
                      padding:
                          EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(globals.yellowColor),
                          padding: MaterialStateProperty.all(EdgeInsets.all(3)),
                        ),
                        child: Text(
                          'OK',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: globals.blackColor,
                          ),
                        ),
                        onPressed: () async {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProdListScreen()),
                              (route) => false);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  void fillControls() {
    if (prodInfo.list.length > 0) {
      _ctrProdTitle.text = prodInfo.list[0].prodcutTitle!;
      _ctrProdSummary.text = prodInfo.list[0].summary!;
      _ctrProdPrice.text = Func.toStr(prodInfo.list[0].productPrice!);
      _ctrDiscount.text = Func.toStr(prodInfo.list[0].discount!);
      _ctrQuantity.text = Func.toStr(prodInfo.list[0].quantity!);
      _ctrGroupQty.text = Func.toStr(prodInfo.list[0].groupQty!);
      _ctrContent.text = prodInfo.list[0].content!;
      _ctrSerialNo.text = prodInfo.list[0].serialNo!;

      _selectedCategory = Func.toStr(prodInfo.list[0].categoryID!);
      isImageSelected = true;
      _strImageUrl = prodInfo.list[0].imageUrl!;
      _ctrImageUrl.text = prodInfo.list[0].imageUrl!;
    }
  }
}
