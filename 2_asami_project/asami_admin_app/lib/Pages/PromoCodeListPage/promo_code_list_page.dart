import 'dart:async';
import 'dart:io';

import 'package:asami_admin_app/Pages/PromoCodePage/promo_code_page.dart';
import 'package:flutter/material.dart';
import 'package:keicy_cupertino_indicator/keicy_cupertino_indicator.dart';
import 'package:keicy_progress_dialog/keicy_progress_dialog.dart';
import 'package:keicy_raised_button/keicy_raised_button.dart';
import 'package:keicy_text_form_field/keicy_text_form_field.dart';
import 'package:provider/provider.dart';

import 'package:image_picker/image_picker.dart';

import 'index.dart';
import 'package:asami_admin_app/Pages/App/index.dart';
import 'package:asami_backend/Models/index.dart';

class PromoCodeListPage extends StatefulWidget {
  @override
  _PromoCodeListPageState createState() => _PromoCodeListPageState();
}

class _PromoCodeListPageState extends State<PromoCodeListPage> {
  PromoCodeListPageStyles _promoCodeListPageStyles;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _promoCodeListPageStyles = PromoCodeListPageMobileStyles(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PromoCodeListPageProvider()),
        ChangeNotifierProvider(create: (_) => PromoCodePagePopupProvider()),
      ],
      child: Builder(builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            if (PromoCodePagePopupProvider.of(context).isPopupWindow) {
              PromoCodePagePopupProvider.of(context).setPromoCodeModel(null);
              PromoCodePagePopupProvider.of(context).setIsNew(false);
              PromoCodePagePopupProvider.of(context).setIsPopupWindow(false);
              return false;
            } else {
              return true;
            }
          },
          child: _containerMain(context),
        );
      }),
    );
  }

  Widget _containerMain(BuildContext context) {
    PromoCodeListPageProvider.of(context).getPromoCodeListStream();

    PromoCodeListPageProvider.of(context).addListener(() async {
      if (PromoCodeListPageProvider.of(context).progressState != 1 && KeicyProgressDialog.of(context).isShowing()) {
        KeicyProgressDialog.of(context).hide();
      }
    });

    return Consumer<PromoCodePagePopupProvider>(builder: (context, promoCodePagePopupProvider, _) {
      return Stack(
        children: [
          Scaffold(
            backgroundColor: PromoCodeListPageColors.backColor,
            appBar: PreferredSize(
              preferredSize: Size(_promoCodeListPageStyles.deviceWidth, _promoCodeListPageStyles.asamiAppbarHeight),
              child: Container(
                padding: EdgeInsets.all(_promoCodeListPageStyles.asamiAppbarBottomPadding),
                alignment: Alignment.bottomCenter,
                color: AppColors.appbarColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      child: Icon(Icons.arrow_back_ios, size: _promoCodeListPageStyles.iconSize, color: Colors.white),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Text(
                      PromoCodeListPageString.appbarTitle,
                      style: TextStyle(
                        fontSize: _promoCodeListPageStyles.appbarTitleFontSize,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      child: Icon(Icons.send, size: _promoCodeListPageStyles.iconSize, color: Colors.transparent),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
            body: Container(
              width: _promoCodeListPageStyles.deviceWidth,
              height: _promoCodeListPageStyles.safeAreaHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: _promoCodeListPageStyles.primaryVerticalPadding),
                  Expanded(
                    child: StreamBuilder<List<Map<String, dynamic>>>(
                      stream: PromoCodeListPageProvider.of(context).promoCodeListStream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return KeicyCupertinoIndicator();
                        if (snapshot.data.length == 0)
                          return Center(
                            child: Text(
                              "No PromoCode Data",
                              style: TextStyle(fontSize: _promoCodeListPageStyles.codeFontSize),
                            ),
                          );

                        return ListView.separated(
                          itemBuilder: (context, index) {
                            PromoCodeModel _promoCodeModel = PromoCodeModel.fromJson(snapshot.data[index]);
                            // _promoCodeModel.title = "Test Title";
                            // _promoCodeModel.description = "Text Description";
                            // _promoCodeModel.promoCode = "Test Code";

                            return GestureDetector(
                              onTap: () {
                                PromoCodePagePopupProvider.of(context).setPromoCodeModel(_promoCodeModel);
                                PromoCodePagePopupProvider.of(context).setIsNew(false);
                                PromoCodePagePopupProvider.of(context).setIsPopupWindow(true);
                              },
                              child: Container(
                                height: _promoCodeListPageStyles.promoCodeItemHeight,
                                margin: EdgeInsets.symmetric(horizontal: _promoCodeListPageStyles.primaryHorizontalPadding),
                                padding: EdgeInsets.symmetric(
                                  horizontal: _promoCodeListPageStyles.promoCodeItemHorizontalPadding,
                                  vertical: _promoCodeListPageStyles.promoCodeItemVerticalPadding,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(_promoCodeListPageStyles.widthDp * 6),
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
                                            style: TextStyle(fontSize: _promoCodeListPageStyles.titleFontSize, fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            _promoCodeModel.promoCode,
                                            style: TextStyle(fontSize: _promoCodeListPageStyles.codeFontSize),
                                          ),
                                          Text(
                                            _promoCodeModel.description,
                                            style: TextStyle(fontSize: _promoCodeListPageStyles.descriptionFontSize),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      child: Icon(
                                        Icons.delete,
                                        size: _promoCodeListPageStyles.iconSize * 0.8,
                                        color: Colors.red,
                                      ),
                                      onTap: () async {
                                        await KeicyProgressDialog.of(context).show();
                                        PromoCodeListPageProvider.of(context).deleteFact(_promoCodeModel);
                                      },
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: _promoCodeListPageStyles.widthDp * 30);
                          },
                          itemCount: snapshot.data.length,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: _promoCodeListPageStyles.primaryVerticalPadding),
                  Container(
                    width: _promoCodeListPageStyles.deviceWidth,
                    padding: EdgeInsets.symmetric(horizontal: _promoCodeListPageStyles.primaryHorizontalPadding),
                    child: KeicyRaisedButton(
                      width: double.infinity,
                      height: _promoCodeListPageStyles.addButtonHeight,
                      color: AppColors.primaryColor,
                      borderRadius: _promoCodeListPageStyles.widthDp * 6,
                      child: Text(
                        PromoCodeListPageString.addButtonText,
                        style: TextStyle(fontSize: _promoCodeListPageStyles.appbarTitleFontSize, color: Colors.white),
                      ),
                      onPressed: () {
                        PromoCodePagePopupProvider.of(context).setPromoCodeModel(PromoCodeModel());
                        PromoCodePagePopupProvider.of(context).setIsNew(true);
                        PromoCodePagePopupProvider.of(context).setIsPopupWindow(true);
                      },
                    ),
                  ),
                  SizedBox(height: _promoCodeListPageStyles.widthDp * 35),
                ],
              ),
            ),
          ),
          (promoCodePagePopupProvider.isPopupWindow)
              ? PromoCodePage(
                  promoCodePagePopupProvider: promoCodePagePopupProvider,
                  promoCodeModel: promoCodePagePopupProvider.promoCodeModel,
                  isNew: promoCodePagePopupProvider.isNew,
                )
              : SizedBox(),
        ],
      );
    });
  }
}
