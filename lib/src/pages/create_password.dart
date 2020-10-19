import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/user_controller.dart';
import '../helpers/app_config.dart' as config;

class CreatePassword extends StatefulWidget {
  @override
  _ForgetPasswordWidgetState createState() => _ForgetPasswordWidgetState();
}

class _ForgetPasswordWidgetState extends StateMVC<CreatePassword> {
  UserController _con;

  // Animation<int> animation;

  _ForgetPasswordWidgetState() : super(UserController()) {
    _con = controller;
  }

  Duration clockTimer = Duration(seconds: 30);
  @override
  void initState() {
    super.initState();
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
            image: AssetImage('assets/img/bg_password.png'),
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
                  'Create New Password',
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
                  'Create new password for your account to be secure.',
                  softWrap: true,
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
                      Container(
                        width: config.App(context).appWidth(84),
                        child: Text(
                          'New Password',
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              .merge(TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              )),
                        ),
                      ),
                      SizedBox(height: 10),
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
                      SizedBox(height: 30),
                      Container(
                        width: config.App(context).appWidth(84),
                        child: Text(
                          'New Password Again',
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              .merge(TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              )),
                        ),
                      ),
                      SizedBox(height: 10),
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
                      SizedBox(
                        height: 30,
                      ),
                      FlatButton(
                        height: 50,
                        child: Text(
                          S.of(context).submit,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        color: Color(0xff60A735),
                        onPressed: () {
                          // _con.resetPassword();
                          Navigator.of(context)
                              .pushReplacementNamed('/ChooseLanguage');
                        },
                      ),
                      SizedBox(height: 10),
                    ],
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
