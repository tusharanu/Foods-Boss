import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery_owner/src/custom/custom_text.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

import '../controllers/user_controller.dart';
import '../helpers/app_config.dart' as config;

class VerifyOtp extends StatefulWidget {
  @override
  _VerifyOtpState createState() => _VerifyOtpState();
}

class _VerifyOtpState extends StateMVC<VerifyOtp> {
  UserController _con;

  // Animation<int> animation;
  int _otpCodeLength = 4;
  bool _isLoadingButton = false;
  bool _enableButton = false;
  String _otpCode = "";
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _start = 60;
  Timer _timer;
  bool resendOtpVisible = false;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            resendOtpVisible = true;
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getSignatureCode();
    startTimer();
  }

  /// get signature code
  _getSignatureCode() async {
    String signature = await SmsRetrieved.getAppSignature();
    print("signature $signature");
  }

  _onSubmitOtp() {
    setState(() {
      _isLoadingButton = !_isLoadingButton;
      _verifyOtpCode();
    });
  }

  _onOtpCallBack(String otpCode, bool isAutofill) {
    setState(() {
      this._otpCode = otpCode;
      if (otpCode.length == _otpCodeLength && isAutofill) {
        _enableButton = false;
        _isLoadingButton = true;
        _verifyOtpCode();
      } else if (otpCode.length == _otpCodeLength && !isAutofill) {
        _enableButton = true;
        _isLoadingButton = false;
      } else {
        _enableButton = false;
      }
    });
  }

  _verifyOtpCode() {
    FocusScope.of(context).requestFocus(new FocusNode());
    Timer(Duration(milliseconds: 4000), () {
      setState(() {
        _isLoadingButton = false;
        _enableButton = false;
      });

      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text("Verification OTP Code $_otpCode Success")));
    });
  }

  _VerifyOtpState() : super(UserController()) {
    _con = controller;
  }
  Duration clockTimer = Duration(seconds: 30);

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
            image: AssetImage('assets/img/bg_verify.png'),
            fit: BoxFit.cover,
          )),
          child: ListView(
            // alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: config.App(context).appWidth(84),
                // height: config.App(context).appHeight(37),
                margin: const EdgeInsets.only(
                  top: 100,
                ),
                child: Text(
                  'Verify Mobile',
                  style: Theme.of(context).textTheme.headline1.merge(TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                      )),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(
                  top: 20,
                ),
                width: config.App(context).appWidth(84),
                // height: config.App(context).appHeight(37),
                child: Text(
                  'Enter OTP sent to 9876543210.',
                  softWrap: true,
                  style: Theme.of(context).textTheme.headline1.merge(TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Wrong Mobilenumber?',
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
                    child: Text(
                      'Click Here.',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
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
                        height: 60,
                        child: TextFieldPin(
                          filled: true,
                          filledColor: Colors.white,
                          codeLength: _otpCodeLength,
                          boxSize: 50,
                          filledAfterTextChange: false,
                          textStyle: TextStyle(fontSize: 16),
                          borderStyle: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onOtpCallback: (code, isAutofill) =>
                              _onOtpCallBack(code, isAutofill),
                        ),
                      ),
                      SizedBox(height: 30),
                      FlatButton(
                        height: 50,
                        // child: _setUpButtonChild(),
                        disabledColor: Colors.blue[100],
                        child: Text(
                          resendOtpVisible ? 'Resend...' : CustomText().verify,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        color: Color(0xff60A735),
                        onPressed: () {
                          // _con.resetPassword();
                          // _enableButton ? _onSubmitOtp : null;
                          // startTimer();
                          Navigator.of(context)
                              .pushReplacementNamed('/CreatePassword');
                        },
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: config.App(context).appWidth(84),
                        // height: config.App(context).appHeight(37),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              CustomText().resend_otp,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .merge(TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                  )),
                            ),
                            Text(
                              '${_start} sec',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .merge(TextStyle(
                                    color: Theme.of(context).errorColor,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                  )),
                            ),
                          ],
                        ),
                      ),
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

  Widget _setUpButtonChild() {
    if (_isLoadingButton) {
      return Container(
        width: 19,
        height: 19,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return Text(
        "Verify",
        style: TextStyle(color: Colors.white),
      );
    }
  }
}
