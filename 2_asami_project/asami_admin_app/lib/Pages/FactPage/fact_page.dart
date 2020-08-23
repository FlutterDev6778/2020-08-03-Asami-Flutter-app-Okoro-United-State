import 'dart:async';
import 'dart:io';

import 'package:asami_admin_app/Pages/CountryCollectionPage/country_collection_page.dart';
import 'package:asami_admin_app/Pages/CountryCollectionPage/index.dart';
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

class FactPage extends StatefulWidget {
  FactPage({
    @required FactPagePopupProvider factPagePopupProvider,
    @required FactModel factModel,
    @required bool isNew,
  }) {
    this.factPagePopupProvider = factPagePopupProvider;
    this.isNew = isNew;
    this.factModel = factModel;
  }
  FactPagePopupProvider factPagePopupProvider;
  bool isNew;
  FactModel factModel;

  @override
  _FactPageState createState() => _FactPageState();
}

class _FactPageState extends State<FactPage> {
  FactPageStyles _factPageStyles;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _factPageStyles = FactPageMobileStyles(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FactPageProvider(factModel: FactModel.fromJson(widget.factModel.toJson()))),
      ],
      child: Builder(builder: (context) {
        return _containerMain(context);
      }),
    );
  }

  Widget _containerMain(BuildContext context) {
    return Consumer<FactPageProvider>(builder: (context, factPageProvider, _) {
      if (factPageProvider.progressState != 1 && KeicyProgressDialog.of(context).isShowing()) {}

      if (factPageProvider.progressState == 2) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          KeicyProgressDialog.of(context).hide();
          // Navigator.of(context).pop();
          widget.factPagePopupProvider.setIsPopupWindow(false);
        });
      } else {
        KeicyProgressDialog.of(context).hide();
      }

      return Scaffold(
        backgroundColor: Colors.black.withAlpha(200),
        body: _containerBody(context, factPageProvider),
      );
    });
  }

  Widget _containerBody(BuildContext context, FactPageProvider factPageProvider) {
    return SingleChildScrollView(
      child: Container(
        width: _factPageStyles.deviceWidth,
        height: _factPageStyles.deviceHeight,
        // color: Colors.white.withAlpha(50),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: _factPageStyles.windowWidth,
                height: _factPageStyles.windowHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(_factPageStyles.widthDp * 8),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: _factPageStyles.primaryHorizontalPadding,
                  vertical: _factPageStyles.primaryVerticalPadding,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      (widget.isNew) ? FactPageString.addTitle : FactPageString.editTitle,
                      style: TextStyle(fontSize: _factPageStyles.titleFontSize, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      style: TextStyle(fontSize: _factPageStyles.textFontSize),
                      maxLines: null,
                      initialValue: factPageProvider.factModel.description,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: FactPageString.descriptionHint,
                      ),
                      onChanged: (input) => factPageProvider.factModel.description = input.trim(),
                      validator: (input) => (input.length < 10) ? ValidateErrorString.textlengthErrorText.replaceAll("{length}", "10") : null,
                      onSaved: (input) => factPageProvider.factModel.description = input.trim(),
                    ),
                    SizedBox(height: _factPageStyles.widthDp * 10),
                    KeicyRaisedButton(
                      width: _factPageStyles.buttonWidth,
                      height: _factPageStyles.buttonHeight,
                      color: AppColors.primaryColor,
                      borderRadius: _factPageStyles.widthDp * 6,
                      child: Text(
                        (widget.isNew) ? FactPageString.addButtonText : FactPageString.saveButtonText,
                        style: TextStyle(fontSize: _factPageStyles.buttonTextFontSize, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        _saveHandler(context, factPageProvider);
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

  void _saveHandler(BuildContext context, FactPageProvider factPageProvider) async {
    if (!_formkey.currentState.validate()) return;
    _formkey.currentState.save();

    if (factPageProvider.factModel.toJson().toString() == widget.factModel.toJson().toString()) {
      return;
    }

    await KeicyProgressDialog.of(context).show();
    factPageProvider.setProgressState(1, isNotifiable: false);

    if (widget.isNew)
      factPageProvider.addFactHandler();
    else
      factPageProvider.updateFactHandler();
  }
}
