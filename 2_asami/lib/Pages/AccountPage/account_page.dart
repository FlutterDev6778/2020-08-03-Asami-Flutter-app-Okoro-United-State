import 'dart:async';

import 'package:flutter/material.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:keicy_network_image/keicy_network_image.dart';

import 'index.dart';
import 'package:asami_app/Pages/App/index.dart';
import 'package:asami_app/Models/index.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> with TickerProviderStateMixin {
  AccountPageStyles _accountPageStyles;
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _accountPageStyles = AccountPageMobileStyles(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AccountPageProvider()),
      ],
      child: _containerMain(context),
    );
  }

  Widget _containerMain(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(_accountPageStyles.deviceWidth, _accountPageStyles.asamiAppbarHeight),
          child: Container(
            padding: EdgeInsets.all(_accountPageStyles.asamiAppbarBottomPadding),
            alignment: Alignment.bottomCenter,
            color: AppColors.appbarColor,
            child: Text(
              AccountPageString.appbarTitle,
              style: TextStyle(
                fontSize: _accountPageStyles.appbarTitleFontSize,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: Container(
          width: _accountPageStyles.deviceWidth,
          height: _accountPageStyles.safeAreaHeight,
          padding: EdgeInsets.symmetric(
            horizontal: _accountPageStyles.primaryHorizontalPadding,
            vertical: _accountPageStyles.primaryVerticalPadding,
          ),
          decoration: BoxDecoration(color: AccountPageColors.backColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                AccountPageString.description,
                style: TextStyle(
                  fontSize: _accountPageStyles.descriptionFontSiz,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: _accountPageStyles.itemSpacing),
              Image.asset(AppAssets.logo1, width: _accountPageStyles.logoImageWidth, fit: BoxFit.fitWidth),
              SizedBox(height: _accountPageStyles.itemSpacing),
              GestureDetector(
                child: Text(
                  AccountPageString.login,
                  style: TextStyle(
                    fontSize: _accountPageStyles.textFontSize,
                    fontStyle: FontStyle.italic,
                    color: AppColors.primaryColor,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationColor: AppColors.primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onTap: () {},
              ),
              SizedBox(height: _accountPageStyles.itemSpacing),
              GestureDetector(
                child: Text(
                  AccountPageString.signup,
                  style: TextStyle(
                    fontSize: _accountPageStyles.textFontSize,
                    fontStyle: FontStyle.italic,
                    color: AppColors.primaryColor,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationColor: AppColors.primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onTap: () {},
              ),
              SizedBox(height: _accountPageStyles.widthDp * 100),
            ],
          ),
        ),
      ),
    );
  }
}
