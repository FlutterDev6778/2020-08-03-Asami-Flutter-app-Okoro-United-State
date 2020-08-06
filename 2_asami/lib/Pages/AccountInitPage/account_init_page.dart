import 'dart:async';

import 'package:flutter/material.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:keicy_network_image/keicy_network_image.dart';

import 'index.dart';
import 'package:asami_app/Pages/App/index.dart';
import 'package:asami_app/Models/index.dart';

class AccountInitPage extends StatefulWidget {
  @override
  _AccountInitPageState createState() => _AccountInitPageState();
}

class _AccountInitPageState extends State<AccountInitPage> with TickerProviderStateMixin {
  AccountInitPageStyles _accountInitPageStyles;
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _accountInitPageStyles = AccountInitPageMobileStyles(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AccountInitPageProvider()),
      ],
      child: _containerMain(context),
    );
  }

  void _accountInitPageProviderListener() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {});
  }

  Widget _containerMain(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(_accountInitPageStyles.deviceWidth, _accountInitPageStyles.asamiAppbarHeight),
          child: Container(
            padding: EdgeInsets.all(_accountInitPageStyles.asamiAppbarBottomPadding),
            alignment: Alignment.bottomCenter,
            color: AppColors.appbarColor,
            child: Text(
              AccountInitPageString.appbarTitle,
              style: TextStyle(
                fontSize: _accountInitPageStyles.appbarTitleFontSize,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: Container(
          width: _accountInitPageStyles.deviceWidth,
          height: _accountInitPageStyles.safeAreaHeight,
          padding: EdgeInsets.symmetric(
            horizontal: _accountInitPageStyles.primaryHorizontalPadding,
            vertical: _accountInitPageStyles.primaryVerticalPadding,
          ),
          decoration: BoxDecoration(color: AccountInitPageColors.backColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                AccountInitPageString.description,
                style: TextStyle(
                  fontSize: _accountInitPageStyles.descriptionFontSiz,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: _accountInitPageStyles.itemSpacing),
              Image.asset(AppAssets.logo1, width: _accountInitPageStyles.logoImageWidth, fit: BoxFit.fitWidth),
              SizedBox(height: _accountInitPageStyles.itemSpacing),
              GestureDetector(
                child: Text(
                  AccountInitPageString.login,
                  style: TextStyle(
                    fontSize: _accountInitPageStyles.textFontSize,
                    fontStyle: FontStyle.italic,
                    color: AppColors.primaryColor,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationColor: AppColors.primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onTap: () {},
              ),
              SizedBox(height: _accountInitPageStyles.itemSpacing),
              GestureDetector(
                child: Text(
                  AccountInitPageString.signup,
                  style: TextStyle(
                    fontSize: _accountInitPageStyles.textFontSize,
                    fontStyle: FontStyle.italic,
                    color: AppColors.primaryColor,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationColor: AppColors.primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onTap: () {},
              ),
              SizedBox(height: _accountInitPageStyles.widthDp * 100),
            ],
          ),
        ),
      ),
    );
  }
}