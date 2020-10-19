import 'package:flutter/material.dart';
import '../custom/custom_text.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
import '../controllers/user_controller.dart';
import '../helpers/app_config.dart' as config;
import '../repository/user_repository.dart' as userRepo;

class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends StateMVC<SignUpWidget> {
  UserController _con;
  bool _check;

  _SignUpWidgetState() : super(UserController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    _check = false;
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
            image: AssetImage('assets/img/bg.png'),
            fit: BoxFit.cover,
          )),
          child: ListView(
            // alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
              Container(
                width: config.App(context).appWidth(84),
                // height: config.App(context).appHeight(37),
                margin: const EdgeInsets.only(
                  top: 40,
                  left: 30,
                ),
                child: Text(
                  CustomText().register,
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
                        keyboardType: TextInputType.text,
                        onSaved: (input) => _con.user.name = input,
                        validator: (input) => input.length < 3
                            ? S.of(context).should_be_more_than_3_letters
                            : null,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelText: CustomText().first_name,
                          labelStyle: TextStyle(
                              color: Theme.of(context)
                                  .shadowColor
                                  .withOpacity(0.4)),
                          contentPadding: EdgeInsets.all(12),
                          hintText: 'First Name',
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
                      SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        onSaved: (input) => _con.user.email = input,
                        validator: (input) => !input.contains('@')
                            ? S.of(context).should_be_a_valid_email
                            : null,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelText: CustomText().last_name,
                          labelStyle: TextStyle(
                              color: Theme.of(context)
                                  .shadowColor
                                  .withOpacity(0.4)),
                          contentPadding: EdgeInsets.all(12),
                          hintText: 'Last Name',
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
                      SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        // onSaved: (input) => _con.user.email = input,
                        validator: (input) => input.length < 10
                            ? CustomText().should_be_atleast_10_digits
                            : null,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelText: CustomText().phone_number,
                          labelStyle: TextStyle(
                              color: Theme.of(context)
                                  .shadowColor
                                  .withOpacity(0.4)),
                          contentPadding: EdgeInsets.all(12),
                          hintText: 'Phone Number',
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
                      SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (input) => _con.user.email = input,
                        validator: (input) => !input.contains('@')
                            ? S.of(context).should_be_a_valid_email
                            : null,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelText: CustomText().email_address,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Theme(
                            data: ThemeData(
                              unselectedWidgetColor: Colors.white,
                            ),
                            child: Checkbox(
                              value: _check,
                              onChanged: (bool change) {
                                setState(() {
                                  _check = change;
                                });
                              },
                            ),
                          ),
                          Text(
                            CustomText().agree_terms_and_conditions,
                            style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      FlatButton(
                        height: 50,
                        child: Text(
                          S.of(context).submit,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        color: Color(0xff60A735),
                        onPressed: () {
                          _con.register();
                          // Navigator.of(context)
                          //     .pushNamed('/MobileVerification');
                        },
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    CustomText().already_have_an_account,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 15,
                    ),
                  ),
                  FlatButton(
                    minWidth: 0,
                    onPressed: () {
                      Navigator.of(context).pushNamed('/Login');
                    },
                    textColor: Color(0xff60A735),
                    child: Text(S.of(context).login),
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
