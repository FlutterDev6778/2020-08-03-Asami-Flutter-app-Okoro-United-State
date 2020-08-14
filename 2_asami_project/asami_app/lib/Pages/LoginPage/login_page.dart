import 'dart:async';

import 'package:asami_app/Pages/AccountPage/account_page.dart';
import 'package:asami_app/Pages/PremiumMemberPage/premium_member_page.dart';
import 'package:asami_app/Pages/SignupPage/signup_page.dart';
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

class LoginPage extends StatefulWidget {
  LoginPage({this.isPremiumUser = false});

  bool isPremiumUser;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginPageStyles _loginPageStyles;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String _email;
  String _password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _loginPageStyles = LoginPageMobileStyles(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginPageProvider()),
      ],
      child: Builder(builder: (context) {
        return _containerMain(context);
      }),
    );
  }

  Widget _containerMain(BuildContext context) {
    /// AuthProvider Listener
    AuthProvider.of(context).addListener(() async {
      if (AuthProvider.of(context).processingState != 1) {
        await KeicyProgressDialog.of(context).hide();
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
          width: _loginPageStyles.deviceWidth,
          height: _loginPageStyles.safeAreaHeight,
          padding: EdgeInsets.symmetric(
            horizontal: _loginPageStyles.primaryHorizontalPadding,
            vertical: _loginPageStyles.primaryVerticalPadding,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _containerAvatarContainer(context),
              SizedBox(height: _loginPageStyles.widthDp * 20),
              _containerForm(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _containerAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(_loginPageStyles.deviceWidth, _loginPageStyles.asamiAppbarHeight),
      child: Container(
        padding: EdgeInsets.all(_loginPageStyles.asamiAppbarBottomPadding),
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
                    child: Icon(Icons.arrow_back_ios, size: _loginPageStyles.appbarIconSize, color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    LoginPageString.appbarTitle,
                    style: TextStyle(
                      fontSize: _loginPageStyles.appbarTitleFontSize,
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
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => SignupPage()));
                    },
                    child: Text(
                      LoginPageString.signupLink,
                      style: TextStyle(fontSize: _loginPageStyles.textFontSize, color: Colors.white),
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

  Widget _containerAvatarContainer(BuildContext context) {
    return Container(
      width: _loginPageStyles.deviceWidth,
      padding: EdgeInsets.symmetric(
        horizontal: _loginPageStyles.avatarContainerHorizontalPadding,
        vertical: _loginPageStyles.avatarContainerVerticalPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(_loginPageStyles.avatarImageSize / 2),
            child: Image.asset(
              AppAssets.avatarImage,
              width: _loginPageStyles.avatarImageSize,
              height: _loginPageStyles.avatarImageSize,
              fit: BoxFit.cover,
            ),
          ),
        ],
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
            height: _loginPageStyles.formFieldHeight,
            fillColor: Colors.white,
            textFontSize: _loginPageStyles.textFontSize,
            hintText: LoginPageString.emailHint,
            borderRadius: _loginPageStyles.formFieldHeight,
            border: Border.all(width: 0, color: Colors.white),
            errorBorder: Border.all(width: 1, color: Colors.red),
            contentHorizontalPadding: _loginPageStyles.widthDp * 20,
            keyboardType: TextInputType.emailAddress,
            onChangeHandler: (input) => _email = input.trim(),
            validatorHandler: (input) => !KeicyValidators.emailRegExp.hasMatch(input.trim()) ? ValidateErrorString.emailErrorText : null,
            onSaveHandler: (input) => _email = input.trim(),
          ),
          SizedBox(height: _loginPageStyles.widthDp * 20),
          KeicyTextFormField(
            width: double.infinity,
            height: _loginPageStyles.formFieldHeight,
            fillColor: Colors.white,
            textFontSize: _loginPageStyles.textFontSize,
            hintText: LoginPageString.passwordHint,
            borderRadius: _loginPageStyles.formFieldHeight,
            border: Border.all(width: 0, color: Colors.white),
            errorBorder: Border.all(width: 1, color: Colors.red),
            contentHorizontalPadding: _loginPageStyles.widthDp * 20,
            obscureText: true,
            onChangeHandler: (input) => _password = input,
            validatorHandler: (input) => input.length < 6 ? ValidateErrorString.textlengthErrorText.replaceAll("{length}", '6') : null,
            onSaveHandler: (input) => _password = input,
          ),
          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    LoginPageString.forgotLabel,
                    style: TextStyle(fontSize: _loginPageStyles.textFontSize, color: AppColors.primaryColor),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: _loginPageStyles.widthDp * 20),
          KeicyRaisedButton(
            width: double.infinity,
            height: _loginPageStyles.formFieldHeight,
            color: AppColors.primaryColor,
            borderRadius: _loginPageStyles.formFieldHeight / 2,
            child: Text(
              LoginPageString.loginbutton,
              style: TextStyle(fontSize: _loginPageStyles.textFontSize, color: Colors.white),
            ),
            onPressed: () {
              _loginHandler(context);
            },
          ),
          SizedBox(height: _loginPageStyles.widthDp * 20),
          Consumer<AuthProvider>(
            builder: (context, loginPageProvider, _) {
              return (loginPageProvider.errorString != "")
                  ? Text(
                      loginPageProvider.errorString,
                      style: TextStyle(fontSize: _loginPageStyles.textFontSize * 0.8, color: Colors.red),
                    )
                  : SizedBox();
            },
          ),
        ],
      ),
    );
  }

  void _loginHandler(BuildContext context) async {
    if (!_formkey.currentState.validate()) return;
    _formkey.currentState.save();

    await KeicyProgressDialog(context).show();
    AuthProvider.of(context).setProcessingState(1);
    AuthProvider.of(context).loginWithEmailOnFirebase(
      email: _email,
      password: _password,
      remeberMe: true,
    );
  }
}
