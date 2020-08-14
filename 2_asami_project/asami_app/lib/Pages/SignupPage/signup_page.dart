import 'dart:async';

import 'package:asami_app/Pages/AccountPage/account_page.dart';
import 'package:asami_app/Pages/LoginPage/login_page.dart';
import 'package:asami_app/Pages/PremiumMemberPage/premium_member_page.dart';
import 'package:flutter/material.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keicy_progress_dialog/keicy_progress_dialog.dart';
import 'package:keicy_raised_button/keicy_raised_button.dart';
import 'package:keicy_text_form_field/keicy_text_form_field.dart';
import 'package:keicy_utils/validators.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:keicy_network_image/keicy_network_image.dart';

import 'index.dart';
import 'package:asami_app/Pages/App/index.dart';
import 'package:asami_backend/Models/index.dart';
import 'package:asami_app/Pages/EditProfilePage/edit_profile_page.dart';
import 'package:asami_app/Pages/TeaClubPage/tea_club_page.dart';

class SignupPage extends StatefulWidget {
  SignupPage({this.isPremiumUser = false});

  bool isPremiumUser;

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  SignupPageStyles _signupPageStyles;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _passwordTextEditingController = TextEditingController();
  TextEditingController _confirmPasswordTextEditingController = TextEditingController();

  String _name;
  String _email;
  String _password;
  String _confrimPassword;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _signupPageStyles = SignupPageMobileStyles(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignupPageProvider()),
      ],
      child: Builder(builder: (context) {
        return _containerMain(context);
      }),
    );
  }

  Widget _containerMain(BuildContext context) {
    /// AuthProvider Listener
    AuthProvider.of(context).addListener(() {
      if (AuthProvider.of(context).processingState != 1) {
        KeicyProgressDialog.of(context).hide();
      }
      if (AuthProvider.of(context).processingState == 2) {
        AuthProvider.of(context).setProcessingState(0, isNotifiable: false);
        Navigator.of(context).pop();
        AuthProvider.of(context).setAuthState(AuthState.IsLogin);
      }
    });

    return Scaffold(
      backgroundColor: AppColors.backColor,
      appBar: _containerAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          width: _signupPageStyles.deviceWidth,
          height: _signupPageStyles.safeAreaHeight,
          padding: EdgeInsets.symmetric(
            horizontal: _signupPageStyles.primaryHorizontalPadding,
            vertical: _signupPageStyles.primaryVerticalPadding,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: _signupPageStyles.widthDp * 40),
              _containerForm(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _containerAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(_signupPageStyles.deviceWidth, _signupPageStyles.asamiAppbarHeight),
      child: Container(
        padding: EdgeInsets.all(_signupPageStyles.asamiAppbarBottomPadding),
        alignment: Alignment.bottomCenter,
        color: AppColors.appbarColor,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.arrow_back_ios, size: _signupPageStyles.appbarIconSize, color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    SignupPageString.appbarTitle,
                    style: TextStyle(
                      fontSize: _signupPageStyles.appbarTitleFontSize,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
                    },
                    child: Text(
                      SignupPageString.loginLink,
                      style: TextStyle(fontSize: _signupPageStyles.textFontSize, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _containerForm(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          KeicyTextFormField(
            width: double.infinity,
            height: _signupPageStyles.formFieldHeight,
            fillColor: Colors.white,
            textFontSize: _signupPageStyles.textFontSize,
            hintText: SignupPageString.nameHint,
            borderRadius: _signupPageStyles.formFieldHeight,
            border: Border.all(width: 0, color: Colors.white),
            errorBorder: Border.all(width: 1, color: Colors.red),
            contentHorizontalPadding: _signupPageStyles.widthDp * 20,
            keyboardType: TextInputType.emailAddress,
            onChangeHandler: (input) => _name = input.trim(),
            validatorHandler: (input) => input.length < 3 ? ValidateErrorString.textlengthErrorText.replaceAll("{length}", '3') : null,
            onSaveHandler: (input) => _name = input.trim(),
          ),
          SizedBox(height: _signupPageStyles.widthDp * 20),
          KeicyTextFormField(
            width: double.infinity,
            height: _signupPageStyles.formFieldHeight,
            fillColor: Colors.white,
            textFontSize: _signupPageStyles.textFontSize,
            hintText: SignupPageString.emailHint,
            borderRadius: _signupPageStyles.formFieldHeight,
            border: Border.all(width: 0, color: Colors.white),
            errorBorder: Border.all(width: 1, color: Colors.red),
            contentHorizontalPadding: _signupPageStyles.widthDp * 20,
            keyboardType: TextInputType.emailAddress,
            onChangeHandler: (input) => _email = input.trim(),
            validatorHandler: (input) => !KeicyValidators.emailRegExp.hasMatch(input.trim()) ? ValidateErrorString.emailErrorText : null,
            onSaveHandler: (input) => _email = input.trim(),
          ),
          SizedBox(height: _signupPageStyles.widthDp * 20),
          KeicyTextFormField(
            width: double.infinity,
            height: _signupPageStyles.formFieldHeight,
            controller: _passwordTextEditingController,
            fillColor: Colors.white,
            textFontSize: _signupPageStyles.textFontSize,
            hintText: SignupPageString.passwordHint,
            borderRadius: _signupPageStyles.formFieldHeight,
            border: Border.all(width: 0, color: Colors.white),
            errorBorder: Border.all(width: 1, color: Colors.red),
            contentHorizontalPadding: _signupPageStyles.widthDp * 20,
            obscureText: true,
            onChangeHandler: (input) => _password = input.trim(),
            validatorHandler: (input) => input.length < 6
                ? ValidateErrorString.textlengthErrorText.replaceAll("{length}", '6')
                : (input != _confirmPasswordTextEditingController.text) ? ValidateErrorString.passwordMatchErrorText : null,
            onSaveHandler: (input) => _password = input,
          ),
          SizedBox(height: _signupPageStyles.widthDp * 20),
          KeicyTextFormField(
            width: double.infinity,
            height: _signupPageStyles.formFieldHeight,
            controller: _confirmPasswordTextEditingController,
            fillColor: Colors.white,
            textFontSize: _signupPageStyles.textFontSize,
            hintText: SignupPageString.confirmPasswordHint,
            borderRadius: _signupPageStyles.formFieldHeight,
            border: Border.all(width: 0, color: Colors.white),
            errorBorder: Border.all(width: 1, color: Colors.red),
            contentHorizontalPadding: _signupPageStyles.widthDp * 20,
            obscureText: true,
            onChangeHandler: (input) => _confrimPassword = input.trim(),
            validatorHandler: (input) => input.length < 6
                ? ValidateErrorString.textlengthErrorText.replaceAll("{length}", '6')
                : (input != _passwordTextEditingController.text) ? ValidateErrorString.passwordMatchErrorText : null,
            onSaveHandler: (input) => _confrimPassword = input,
          ),
          SizedBox(height: _signupPageStyles.widthDp * 20),
          KeicyRaisedButton(
            width: double.infinity,
            height: _signupPageStyles.formFieldHeight,
            color: AppColors.primaryColor,
            borderRadius: _signupPageStyles.formFieldHeight / 2,
            child: Text(
              SignupPageString.signupbutton,
              style: TextStyle(fontSize: _signupPageStyles.textFontSize, color: Colors.white),
            ),
            onPressed: () {
              _signupHandler(context);
            },
          ),
          SizedBox(height: _signupPageStyles.widthDp * 20),
          Consumer<AuthProvider>(
            builder: (context, signupPageProvider, _) {
              return (signupPageProvider.errorString != "")
                  ? Text(
                      signupPageProvider.errorString,
                      style: TextStyle(fontSize: _signupPageStyles.textFontSize * 0.8, color: Colors.red),
                    )
                  : SizedBox();
            },
          ),
        ],
      ),
    );
  }

  void _signupHandler(BuildContext context) async {
    if (!_formkey.currentState.validate()) return;
    _formkey.currentState.save();

    UserModel _userModel = UserModel();
    _userModel.name = _name;
    _userModel.email = _email;
    _userModel.isPremium = widget.isPremiumUser;

    await KeicyProgressDialog(context).show();
    AuthProvider.of(context).setProcessingState(1);
    AuthProvider.of(context).signupWithEmailOnFirebase(
      userModel: _userModel,
      password: _password,
    );
  }
}
