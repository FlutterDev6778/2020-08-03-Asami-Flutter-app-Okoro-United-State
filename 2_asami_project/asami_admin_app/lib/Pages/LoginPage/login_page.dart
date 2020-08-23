import 'package:flutter/material.dart';
import 'package:keicy_progress_dialog/keicy_progress_dialog.dart';
import 'package:provider/provider.dart';

import 'package:keicy_raised_button/keicy_raised_button.dart';
import 'package:keicy_text_form_field/keicy_text_form_field.dart';
import 'package:keicy_utils/validators.dart';

import 'package:asami_admin_app/Pages/App/index.dart';
import 'package:asami_admin_app/Pages/DashboardPage/dashboard_page.dart';

import 'index.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  LoginPageStyles _loginPageStyles;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String _email = "";
  String _password = "";

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
        AuthProvider.of(context).setAuthState(AuthState.IsLogin);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => DashboardPage()),
        );
      }
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: _loginPageStyles.deviceWidth,
          height: _loginPageStyles.safeAreaHeight,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(AppAssets.splash), fit: BoxFit.cover),
          ),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: _loginPageStyles.logo1ImageTop),
                Image.asset(
                  AppAssets.logo1,
                  width: _loginPageStyles.logo1ImageWidth,
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(height: _loginPageStyles.widthDp * 24),
                Text(
                  LoginPageString.adminLabel,
                  style: TextStyle(fontSize: _loginPageStyles.textFontSize, fontWeight: FontWeight.bold),
                ),
                Expanded(child: _containerForm(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _containerForm(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          KeicyTextFormField(
            width: _loginPageStyles.textFieldWidth,
            height: _loginPageStyles.textFieldHeight,
            border: Border(bottom: BorderSide(color: Colors.white, width: 2)),
            errorBorder: Border(bottom: BorderSide(color: Colors.red)),
            prefixIcons: <Widget>[
              Icon(Icons.email, size: _loginPageStyles.iconSize, color: Colors.black),
            ],
            fillColor: Colors.transparent,
            textColor: Colors.white,
            textFontSize: _loginPageStyles.textFontSize,
            hintText: LoginPageString.emailHint,
            hintTextColor: Colors.white.withAlpha(150),
            keyboardType: TextInputType.emailAddress,
            onChangeHandler: (input) => _email = input.trim(),
            validatorHandler: (input) => !KeicyValidators.emailRegExp.hasMatch(input.trim()) ? ValidateErrorString.emailErrorText : null,
            onSaveHandler: (input) => _email = input.trim(),
          ),
          SizedBox(height: _loginPageStyles.widthDp * 10),
          KeicyTextFormField(
            width: _loginPageStyles.textFieldWidth,
            height: _loginPageStyles.textFieldHeight,
            border: Border(bottom: BorderSide(color: Colors.white, width: 2)),
            errorBorder: Border(bottom: BorderSide(color: Colors.red)),
            prefixIcons: <Widget>[
              Icon(Icons.lock, size: _loginPageStyles.iconSize, color: Colors.black),
            ],
            fillColor: Colors.transparent,
            textColor: Colors.white,
            textFontSize: _loginPageStyles.textFontSize,
            hintText: LoginPageString.passwordHint,
            hintTextColor: Colors.white.withAlpha(150),
            obscureText: true,
            onChangeHandler: (input) => _password = input.trim(),
            validatorHandler: (input) => input.length < 6 ? ValidateErrorString.textlengthErrorText.replaceAll("{length}", '6') : null,
            onSaveHandler: (input) => _password = input.trim(),
          ),
          SizedBox(height: _loginPageStyles.widthDp * 20),
          Consumer<AuthProvider>(
            builder: (context, loginPageProvider, _) {
              return (loginPageProvider.errorString != "")
                  ? Text(
                      loginPageProvider.errorString,
                      style: TextStyle(fontSize: _loginPageStyles.textFontSize * 0.8, color: Colors.red),
                      textAlign: TextAlign.center,
                    )
                  : SizedBox();
            },
          ),
          SizedBox(height: _loginPageStyles.textFieldHeight),
          KeicyRaisedButton(
            width: _loginPageStyles.buttonWidth,
            height: _loginPageStyles.buttonHeight,
            color: AppColors.primaryColor,
            borderRadius: _loginPageStyles.widthDp * 6,
            child: Text(
              LoginPageString.loginButton,
              style: TextStyle(fontSize: _loginPageStyles.textFontSize, color: Colors.white),
            ),
            onPressed: () {
              _loginHandler(context);
            },
          ),
          SizedBox(height: _loginPageStyles.textFieldHeight),
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
      isAdmin: true,
    );
  }
}
