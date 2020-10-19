import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../controllers/user_controller.dart';
import '../helpers/app_config.dart' as config;

class ChooseLocation extends StatefulWidget {
  @override
  _ForgetPasswordWidgetState createState() => _ForgetPasswordWidgetState();
}

class _ForgetPasswordWidgetState extends StateMVC<ChooseLocation> {
  UserController _con;

  // Animation<int> animation;

  _ForgetPasswordWidgetState() : super(UserController()) {
    _con = controller;
  }

  String language;
  List<String> languageList = List();
  // List<dynamic>
  Duration clockTimer = Duration(seconds: 30);
  @override
  void initState() {
    super.initState();
    languageList = <String>['English', 'Hindi'];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.height / 2.2;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _con.scaffoldKey,
        resizeToAvoidBottomPadding: false,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/img/bg_reset.png'),
            fit: BoxFit.cover,
          )),
          child: ListView(
            // alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
              SizedBox(
                height: size,
              ),
              Container(
                width: config.App(context).appWidth(84),
                // height: config.App(context).appHeight(37),
                margin: const EdgeInsets.only(
                  // top: 250,
                  left: 30,
                ),
                child: Text(
                  'Choose Your',
                  style: Theme.of(context).textTheme.headline1.merge(TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                      )),
                ),
              ),
              Container(
                width: config.App(context).appWidth(84),
                // height: config.App(context).appHeight(37),
                margin: const EdgeInsets.only(
                  // top: 10,
                  left: 30,
                ),
                child: Text(
                  'Location',
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
                  bottom: 50,
                ),
                width: config.App(context).appWidth(84),
                // height: config.App(context).appHeight(37),
                child: Text(
                  'Choose a location below to get started',
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
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (input) => _con.user.email = input,
                        validator: (input) => !input.contains('@')
                            ? S.of(context).should_be_a_valid_email
                            : null,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelText: 'Enter Location',
                          labelStyle: TextStyle(
                              color: Theme.of(context)
                                  .shadowColor
                                  .withOpacity(0.4)),
                          contentPadding: EdgeInsets.all(12),
                          hintText: 'Enter Location',
                          hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.7)),
                          suffixIcon: Icon(Icons.my_location,
                              color: Theme.of(context).accentColor),
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
                          'Next',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        color: Color(0xff60A735),
                        onPressed: () {
                          // _con.resetPassword();
                          Navigator.of(context)
                              .pushReplacementNamed('/Dashboard');
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
