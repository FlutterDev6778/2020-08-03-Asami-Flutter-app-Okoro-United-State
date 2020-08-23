import 'dart:async';
import 'dart:io';

import 'package:asami_admin_app/Pages/CountryCollectionPage/country_collection_page.dart';
import 'package:asami_admin_app/Pages/CountryCollectionPage/index.dart';
import 'package:asami_admin_app/Pages/PromoCodeListPage/Providers/index.dart';
import 'package:asami_backend/asami_backend.dart';
import 'package:flutter/material.dart';
import 'package:keicy_network_image/keicy_network_image.dart';
import 'package:keicy_progress_dialog/keicy_progress_dialog.dart';
import 'package:keicy_raised_button/keicy_raised_button.dart';
import 'package:keicy_text_form_field/keicy_text_form_field.dart';
import 'package:provider/provider.dart';

import 'package:image_picker/image_picker.dart';

import 'index.dart';
import 'package:asami_admin_app/Pages/App/index.dart';

class PromoCodePage extends StatefulWidget {
  PromoCodePage({
    @required PromoCodePagePopupProvider promoCodePagePopupProvider,
    @required PromoCodeModel promoCodeModel,
    @required bool isNew,
  }) {
    this.promoCodePagePopupProvider = promoCodePagePopupProvider;
    this.isNew = isNew;
    this.promoCodeModel = promoCodeModel;
  }
  PromoCodePagePopupProvider promoCodePagePopupProvider;
  bool isNew;
  PromoCodeModel promoCodeModel;

  @override
  _PromoCodePageState createState() => _PromoCodePageState();
}

class _PromoCodePageState extends State<PromoCodePage> {
  PromoCodePageStyles _promoCodePageStyles;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _promoCodePageStyles = PromoCodePageMobileStyles(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PromoCodePageProvider(promoCodeModel: PromoCodeModel.fromJson(widget.promoCodeModel.toJson()))),
      ],
      child: Builder(builder: (context) {
        return _containerMain(context);
      }),
    );
  }

  Widget _containerMain(BuildContext context) {
    return Consumer<PromoCodePageProvider>(builder: (context, promoCodePageProvider, _) {
      if (promoCodePageProvider.progressState != 1 && KeicyProgressDialog.of(context).isShowing()) {}

      if (promoCodePageProvider.progressState == 2) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          KeicyProgressDialog.of(context).hide();
          // Navigator.of(context).pop();
          widget.promoCodePagePopupProvider.setIsPopupWindow(false);
        });
      } else {
        KeicyProgressDialog.of(context).hide();
      }

      return Scaffold(
        backgroundColor: Colors.black.withAlpha(200),
        body: _containerBody(context, promoCodePageProvider),
      );
    });
  }

  Widget _containerBody(BuildContext context, PromoCodePageProvider promoCodePageProvider) {
    return SingleChildScrollView(
      child: Container(
        width: _promoCodePageStyles.deviceWidth,
        height: _promoCodePageStyles.deviceHeight,
        // color: Colors.white.withAlpha(50),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: _promoCodePageStyles.windowWidth,
                height: _promoCodePageStyles.windowHeight,
                decoration: BoxDecoration(
                  color: PromoCodePageColors.backColor,
                  borderRadius: BorderRadius.circular(_promoCodePageStyles.widthDp * 8),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: _promoCodePageStyles.primaryHorizontalPadding,
                  vertical: _promoCodePageStyles.primaryVerticalPadding,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(height: _promoCodePageStyles.itemSpacing),
                    Text(
                      (widget.isNew) ? PromoCodePageString.addTitle : PromoCodePageString.editTitle,
                      style: TextStyle(fontSize: _promoCodePageStyles.titleFontSize, fontWeight: FontWeight.bold),
                    ),

                    /// title
                    SizedBox(height: _promoCodePageStyles.itemSpacing),
                    KeicyTextFormField(
                      width: double.infinity,
                      height: _promoCodePageStyles.textFieldHeight,
                      initialValue: promoCodePageProvider.promoCodeModel.title,
                      textFontSize: _promoCodePageStyles.textFontSize,
                      hintText: PromoCodePageString.titleHint,
                      border: Border.all(width: 1, color: Colors.white),
                      errorBorder: Border.all(width: 1, color: Colors.red),
                      onChangeHandler: (input) => promoCodePageProvider.promoCodeModel.title = input.trim(),
                      validatorHandler: (input) => (input.length < 3) ? ValidateErrorString.textlengthErrorText.replaceAll("{length}", "3") : null,
                      onSaveHandler: (input) => promoCodePageProvider.promoCodeModel.title = input.trim(),
                    ),

                    /// PromoCode
                    KeicyTextFormField(
                      width: double.infinity,
                      height: _promoCodePageStyles.textFieldHeight,
                      initialValue: promoCodePageProvider.promoCodeModel.promoCode,
                      textFontSize: _promoCodePageStyles.textFontSize,
                      hintText: PromoCodePageString.promoCodeHint,
                      border: Border.all(width: 1, color: Colors.white),
                      errorBorder: Border.all(width: 1, color: Colors.red),
                      onChangeHandler: (input) => promoCodePageProvider.promoCodeModel.promoCode = input.trim(),
                      validatorHandler: (input) => (input.length < 8) ? ValidateErrorString.textlengthErrorText.replaceAll("{length}", "8") : null,
                      onSaveHandler: (input) => promoCodePageProvider.promoCodeModel.promoCode = input.trim(),
                    ),

                    /// description
                    KeicyTextFormField(
                      width: double.infinity,
                      height: _promoCodePageStyles.descriptionFieldHeight,
                      initialValue: promoCodePageProvider.promoCodeModel.description,
                      textFontSize: _promoCodePageStyles.textFontSize,
                      hintText: PromoCodePageString.descriptionHint,
                      border: Border.all(width: 1, color: Colors.white),
                      errorBorder: Border.all(width: 1, color: Colors.red),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      onChangeHandler: (input) => promoCodePageProvider.promoCodeModel.description = input.trim(),
                      validatorHandler: (input) => (input.length < 10) ? ValidateErrorString.textlengthErrorText.replaceAll("{length}", "10") : null,
                      onSaveHandler: (input) => promoCodePageProvider.promoCodeModel.description = input.trim(),
                    ),
                    Text(
                      promoCodePageProvider.errorString,
                      style: TextStyle(fontSize: _promoCodePageStyles.textFontSize * 0.8, color: Colors.red),
                    ),
                    SizedBox(height: _promoCodePageStyles.itemSpacing * 2),
                    KeicyRaisedButton(
                      width: _promoCodePageStyles.buttonWidth,
                      height: _promoCodePageStyles.buttonHeight,
                      color: AppColors.primaryColor,
                      borderRadius: _promoCodePageStyles.widthDp * 6,
                      child: Text(
                        (widget.isNew) ? PromoCodePageString.addButtonText : PromoCodePageString.saveButtonText,
                        style: TextStyle(fontSize: _promoCodePageStyles.buttonTextFontSize, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        _saveHandler(context, promoCodePageProvider);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveHandler(BuildContext context, PromoCodePageProvider promoCodePageProvider) async {
    if (!_formkey.currentState.validate()) return;
    _formkey.currentState.save();

    if (promoCodePageProvider.promoCodeModel.toJson().toString() == widget.promoCodeModel.toJson().toString()) {
      promoCodePageProvider.setErrorString("Don't change Contents");
      return;
    }

    await KeicyProgressDialog.of(context).show();
    promoCodePageProvider.setProgressState(1, isNotifiable: false);

    if (widget.isNew)
      promoCodePageProvider.addPromoCodeHandler();
    else
      promoCodePageProvider.updatePromoCodeHandler();
  }
}
