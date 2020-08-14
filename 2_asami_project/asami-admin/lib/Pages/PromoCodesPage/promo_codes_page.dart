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
import 'package:asami_backend/Models/index.dart';

class PromoCodesPage extends StatefulWidget {
  @override
  _PromoCodesPageState createState() => _PromoCodesPageState();
}

class _PromoCodesPageState extends State<PromoCodesPage> {
  PromoCodesPageStyles _promoCodesPageStyles;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _promoCodesPageStyles = PromoCodesPageMobileStyles(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PromoCodesPageProvider()),
      ],
      child: Builder(builder: (context) {
        return _containerMain(context);
      }),
    );
  }

  Widget _containerMain(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: PromoCodesPageColors.backColor,
        appBar: PreferredSize(
          preferredSize: Size(_promoCodesPageStyles.deviceWidth, _promoCodesPageStyles.asamiAppbarHeight),
          child: Container(
            padding: EdgeInsets.all(_promoCodesPageStyles.asamiAppbarBottomPadding),
            alignment: Alignment.bottomCenter,
            color: AppColors.appbarColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  child: Icon(Icons.arrow_back_ios, size: _promoCodesPageStyles.iconSize, color: Colors.white),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                Text(
                  PromoCodesPageString.appbarTitle,
                  style: TextStyle(
                    fontSize: _promoCodesPageStyles.appbarTitleFontSize,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  child: Icon(Icons.send, size: _promoCodesPageStyles.iconSize, color: Colors.transparent),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
        body: Container(
          width: _promoCodesPageStyles.deviceWidth,
          height: _promoCodesPageStyles.safeAreaHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: _promoCodesPageStyles.primaryVerticalPadding),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    PromoCodeModel _promoCodeModel = PromoCodeModel();
                    _promoCodeModel.title = "Test Title";
                    _promoCodeModel.description = "Text Description";
                    _promoCodeModel.promoCode = "Test Code";

                    return Container(
                      height: _promoCodesPageStyles.promoCodeItemHeight,
                      margin: EdgeInsets.symmetric(horizontal: _promoCodesPageStyles.primaryHorizontalPadding),
                      padding: EdgeInsets.symmetric(
                        horizontal: _promoCodesPageStyles.promoCodeItemHorizontalPadding,
                        vertical: _promoCodesPageStyles.promoCodeItemVerticalPadding,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(_promoCodesPageStyles.widthDp * 6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  _promoCodeModel.title,
                                  style: TextStyle(fontSize: _promoCodesPageStyles.titleFontSize, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  _promoCodeModel.promoCode,
                                  style: TextStyle(fontSize: _promoCodesPageStyles.codeFontSize),
                                ),
                                Text(
                                  _promoCodeModel.description,
                                  style: TextStyle(fontSize: _promoCodesPageStyles.descriptionFontSize),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.delete,
                            size: _promoCodesPageStyles.iconSize * 0.8,
                            color: Colors.red,
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: _promoCodesPageStyles.widthDp * 30);
                  },
                  itemCount: 20,
                ),
              ),
              SizedBox(height: _promoCodesPageStyles.primaryVerticalPadding),
              Container(
                width: _promoCodesPageStyles.deviceWidth,
                padding: EdgeInsets.symmetric(horizontal: _promoCodesPageStyles.primaryHorizontalPadding),
                child: KeicyRaisedButton(
                  width: double.infinity,
                  height: _promoCodesPageStyles.addButtonHeight,
                  color: AppColors.primaryColor,
                  borderRadius: _promoCodesPageStyles.widthDp * 6,
                  child: Text(
                    PromoCodesPageString.addButtonText,
                    style: TextStyle(fontSize: _promoCodesPageStyles.appbarTitleFontSize, color: Colors.white),
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(height: _promoCodesPageStyles.widthDp * 35),
            ],
          ),
        ),
      ),
    );
  }
}
