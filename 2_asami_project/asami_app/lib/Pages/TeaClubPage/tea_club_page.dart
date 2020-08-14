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

class TeaClubPage extends StatefulWidget {
  @override
  _TeaClubPageState createState() => _TeaClubPageState();
}

class _TeaClubPageState extends State<TeaClubPage> with TickerProviderStateMixin {
  TeaClubPageStyles _teaClubPageStyles;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _teaClubPageStyles = TeaClubPageMobileStyles(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TeaClubPageProvider()),
      ],
      child: Builder(builder: (context) {
        return _containerMain(context);
      }),
    );
  }

  Widget _containerMain(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(_teaClubPageStyles.deviceWidth, _teaClubPageStyles.asamiAppbarHeight),
        child: Container(
          padding: EdgeInsets.all(_teaClubPageStyles.asamiAppbarBottomPadding),
          alignment: Alignment.bottomCenter,
          color: AppColors.appbarColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  size: _teaClubPageStyles.appbarIconSize,
                  color: Colors.white,
                ),
              ),
              Text(
                TeaClubPageString.appbarTitle,
                style: TextStyle(
                  fontSize: _teaClubPageStyles.appbarTitleFontSize,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  size: _teaClubPageStyles.appbarIconSize,
                  color: AppColors.appbarColor,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: _teaClubPageStyles.deviceWidth,
          height: _teaClubPageStyles.safeAreaHeight,
          padding: EdgeInsets.symmetric(
            horizontal: _teaClubPageStyles.primaryHorizontalPadding,
            vertical: _teaClubPageStyles.primaryVerticalPadding,
          ),
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                AppAssets.subscriptionImage,
                width: _teaClubPageStyles.imageWidth,
                height: _teaClubPageStyles.imageHeight,
                fit: BoxFit.cover,
              ),
              SizedBox(height: _teaClubPageStyles.itemSpacing),
              Text(
                TeaClubPageString.subScriptionStateLabel + TeaClubPageString.activeSubScription,
                style: TextStyle(fontSize: _teaClubPageStyles.textFontSize, color: AppColors.primaryColor),
              ),
              SizedBox(height: _teaClubPageStyles.itemSpacing),
              Text(
                TeaClubPageString.expirationLabel + "03/21/2020",
                style: TextStyle(fontSize: _teaClubPageStyles.textFontSize, color: AppColors.primaryColor),
              ),
              SizedBox(height: _teaClubPageStyles.itemSpacing),
              Text(
                TeaClubPageString.description,
                style: TextStyle(fontSize: _teaClubPageStyles.textFontSize, color: AppColors.primaryColor),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: _teaClubPageStyles.itemSpacing),
              SizedBox(height: _teaClubPageStyles.itemSpacing),
              KeicyRaisedButton(
                width: double.infinity,
                height: _teaClubPageStyles.buttonHeight,
                borderColor: Colors.black,
                borderRadius: _teaClubPageStyles.widthDp * 6,
                borderWidth: 1,
                child: Text(
                  TeaClubPageString.membership1,
                  style: TextStyle(fontSize: _teaClubPageStyles.textFontSize, color: AppColors.primaryColor),
                ),
                onPressed: () {},
              ),
              SizedBox(height: _teaClubPageStyles.itemSpacing),
              KeicyRaisedButton(
                width: double.infinity,
                height: _teaClubPageStyles.buttonHeight,
                borderColor: Colors.black,
                borderRadius: _teaClubPageStyles.widthDp * 6,
                borderWidth: 1,
                child: Text(
                  TeaClubPageString.membership2,
                  style: TextStyle(fontSize: _teaClubPageStyles.textFontSize, color: AppColors.primaryColor),
                ),
                onPressed: () {},
              ),
              SizedBox(height: _teaClubPageStyles.itemSpacing),
              KeicyRaisedButton(
                width: double.infinity,
                height: _teaClubPageStyles.buttonHeight,
                borderColor: Colors.black,
                borderWidth: 1,
                borderRadius: _teaClubPageStyles.widthDp * 6,
                child: Text(
                  TeaClubPageString.membership3,
                  style: TextStyle(fontSize: _teaClubPageStyles.textFontSize, color: AppColors.primaryColor),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
