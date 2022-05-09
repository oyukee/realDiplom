import 'package:flutter/material.dart';
import 'package:together_app/components/no_account_text.dart';
import '../../../size_config.dart';
import 'sign_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:together_app/utils/globals.dart' as globals;

class Body extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: MediaQuery.of(context).viewInsets,
        
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 210,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.topCenter,
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/egch.png"),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20)),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: SizeConfig.screenHeight * 0.08),
                          Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: SignForm(),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: NoAccountText(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
