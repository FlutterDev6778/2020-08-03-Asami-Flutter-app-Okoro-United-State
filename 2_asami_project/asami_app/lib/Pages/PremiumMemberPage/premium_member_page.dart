import 'dart:async';

import 'package:flutter/material.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:keicy_progress_dialog/keicy_progress_dialog.dart';
import 'package:keicy_raised_button/keicy_raised_button.dart';
import 'package:keicy_text_form_field/keicy_text_form_field.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:keicy_network_image/keicy_network_image.dart';

import 'index.dart';
import 'package:asami_app/Pages/App/index.dart';
import 'package:asami_backend/Models/index.dart';

class PremiumMemberPage extends StatefulWidget {
  @override
  _PremiumMemberPageState createState() => _PremiumMemberPageState();
}

class _PremiumMemberPageState extends State<PremiumMemberPage> with TickerProviderStateMixin {
  PremiumMemberPageStyles _premiumMemberPageStyles;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _premiumMemberPageStyles = PremiumMemberPageMobileStyles(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PremiumMemberPageProvider()),
      ],
      child: Builder(builder: (context) {
        return _containerMain(context);
      }),
    );
  }

  Widget _containerMain(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(_premiumMemberPageStyles.deviceWidth, _premiumMemberPageStyles.asamiAppbarHeight),
        child: Container(
          padding: EdgeInsets.all(_premiumMemberPageStyles.asamiAppbarBottomPadding),
          alignment: Alignment.bottomCenter,
          color: AppColors.appbarColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // GestureDetector(
              //   onTap: () {
              //     Navigator.of(context).pop();
              //   },
              //   child: Icon(
              //     Icons.arrow_back_ios,
              //     size: _premiumMemberPageStyles.appbarIconSize,
              //     color: Colors.white,
              //   ),
              // ),
              Text(
                PremiumMemberPageString.appbarTitle,
                style: TextStyle(
                  fontSize: _premiumMemberPageStyles.appbarTitleFontSize,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.of(context).pop();
              //   },
              //   child: Icon(
              //     Icons.arrow_back_ios,
              //     size: _premiumMemberPageStyles.appbarIconSize,
              //     color: AppColors.appbarColor,
              //   ),
              // ),
            ],
          ),
        ),
      ),
      body: Container(
        width: _premiumMemberPageStyles.deviceWidth,
        height: _premiumMemberPageStyles.safeAreaHeight,
        padding: EdgeInsets.symmetric(
          horizontal: _premiumMemberPageStyles.primaryHorizontalPadding,
          vertical: _premiumMemberPageStyles.primaryVerticalPadding,
        ),
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            KeicyRaisedButton(
              width: double.infinity,
              height: _premiumMemberPageStyles.buttonHeight,
              borderColor: Colors.white,
              borderWidth: 1,
              borderRadius: _premiumMemberPageStyles.widthDp * 6,
              child: Container(
                width: _premiumMemberPageStyles.deviceWidth - _premiumMemberPageStyles.primaryHorizontalPadding * 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      PremiumMemberPageString.offerText,
                      style: TextStyle(fontSize: _premiumMemberPageStyles.textFontSize, color: AppColors.primaryColor),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: _premiumMemberPageStyles.iconSize,
                    )
                  ],
                ),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
