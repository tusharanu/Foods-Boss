import 'package:flutter/material.dart';
import '../custom/custom_text.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/user_controller.dart';
import '../helpers/app_config.dart' as config;
import '../repository/user_repository.dart' as userRepo;

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends StateMVC<LoginWidget> {
  UserController _con;
  bool _check = false;

  _LoginWidgetState() : super(UserController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    if (userRepo.currentUser.value?.apiToken != null) {
      Navigator.of(context).pushReplacementNamed('/Pages', arguments: 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _con.scaffoldKey,
        resizeToAvoidBottomPadding: false,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/img/bg_login.png'),
            fit: BoxFit.cover,
          )),
          child: ListView(
            // alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
              Container(
                width: config.App(context).appWidth(84),
                // height: config.App(context).appHeight(37),
                margin: const EdgeInsets.only(
                  top: 100,
                  left: 30,
                ),
                child: Text(
                  S.of(context).login,
                  style: Theme.of(context).textTheme.headline1.merge(TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                      )),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 30,
                  top: 20,
                ),
                width: config.App(context).appWidth(84),
                // height: config.App(context).appHeight(37),
                child: Text(
                  CustomText().enter_your_details_to_continue,
                  style: Theme.of(context).textTheme.headline1.merge(TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      )),
                ),
              ),
              Container(
                // margin: EdgeInsets.symmetric(
                //   horizontal: 20,
                // ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 27),
                width: config.App(context).appWidth(88),
//              height: config.App(context).appHeight(55),
                child: Form(
                  key: _con.loginFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (input) => _con.user.email = input,
                        validator: (input) => !input.contains('@')
                            ? S.of(context).should_be_a_valid_email
                            : null,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelText: S.of(context).email,
                          labelStyle: TextStyle(
                              color: Theme.of(context)
                                  .shadowColor
                                  .withOpacity(0.4)),
                          contentPadding: EdgeInsets.all(12),
                          hintText: 'Email',
                          hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.7)),
                          // prefixIcon: Icon(Icons.alternate_email,
                          //     color: Theme.of(context).accentColor),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                        ),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        onSaved: (input) => _con.user.password = input,
                        validator: (input) => input.length < 3
                            ? S.of(context).should_be_more_than_3_characters
                            : null,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelText: S.of(context).password,
                          labelStyle: TextStyle(
                              color: Theme.of(context)
                                  .shadowColor
                                  .withOpacity(0.4)),
                          contentPadding: EdgeInsets.all(12),
                          hintText: 'johndoe@gmail.com',
                          hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.7)),

                          // prefixIcon: Icon(Icons.alternate_email,
                          //     color: Theme.of(context).accentColor),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                        ),
                      ),
                      // SizedBox(height: 10),
                      SizedBox(height: 30),
                      FlatButton(
                        height: 50,
                        child: Text(
                          S.of(context).submit,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        color: Color(0xff60A735),
                        onPressed: () {
                          _con.login();
                        },
                      ),
                      SizedBox(height: 25),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed('/ForgetPassword');
                  },
                  child: Text(
                    CustomText().forget_password,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    CustomText().do_not_have_an_account,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 15,
                    ),
                  ),
                  FlatButton(
                    minWidth: 0,
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/SignUp');
                    },
                    textColor: Color(0xff60A735),
                    child: Text(S.of(context).register),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
