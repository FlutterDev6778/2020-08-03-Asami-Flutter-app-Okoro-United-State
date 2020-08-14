import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:keicy_raised_button/keicy_raised_button.dart';
import 'package:keicy_text_form_field/keicy_text_form_field.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:image_picker/image_picker.dart';

import 'index.dart';
import 'package:asami_app/Pages/App/index.dart';

class CountriesPage extends StatefulWidget {
  @override
  _CountriesPageState createState() => _CountriesPageState();
}

class _CountriesPageState extends State<CountriesPage> {
  CountriesPageStyles _countriesPageStyles;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _countriesPageStyles = CountriesPageMobileStyles(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CountriesPageProvider()),
      ],
      child: Builder(builder: (context) {
        return _containerMain(context);
      }),
    );
  }

  Widget _containerMain(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CountriesPageColors.backColor,
        appBar: PreferredSize(
          preferredSize: Size(_countriesPageStyles.deviceWidth, _countriesPageStyles.asamiAppbarHeight),
          child: Container(
            padding: EdgeInsets.all(_countriesPageStyles.asamiAppbarBottomPadding),
            alignment: Alignment.bottomCenter,
            color: AppColors.appbarColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  child: Icon(Icons.arrow_back_ios, size: _countriesPageStyles.iconSize, color: Colors.white),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                Text(
                  CountriesPageString.appbarTitle,
                  style: TextStyle(
                    fontSize: _countriesPageStyles.appbarTitleFontSize,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  child: Icon(Icons.send, size: _countriesPageStyles.iconSize, color: Colors.transparent),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
        body: Container(
          width: _countriesPageStyles.deviceWidth,
          height: _countriesPageStyles.safeAreaHeight,
          padding: EdgeInsets.symmetric(vertical: _countriesPageStyles.primaryVerticalPadding),
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                height: _countriesPageStyles.countryItemHeight,
                margin: EdgeInsets.symmetric(horizontal: _countriesPageStyles.primaryHorizontalPadding),
                padding: EdgeInsets.symmetric(horizontal: _countriesPageStyles.countryItemHorizontalPadding),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(_countriesPageStyles.widthDp * 6),
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Countire",
                  style: TextStyle(fontSize: _countriesPageStyles.textFontSize, fontWeight: FontWeight.bold),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: _countriesPageStyles.widthDp * 30);
            },
            itemCount: 20,
          ),
        ),
      ),
    );
  }
}
