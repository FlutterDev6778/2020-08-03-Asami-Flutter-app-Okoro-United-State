import 'dart:async';
import 'dart:io';

import 'package:asami_admin_app/Pages/CountryCollectionPage/country_collection_page.dart';
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

class AttractionPage extends StatefulWidget {
  AttractionPage({@required AttractionModel attractionModel, bool isNew = false}) {
    this.isNew = isNew;
    this.attractionModel = attractionModel;
  }

  bool isNew;
  AttractionModel attractionModel;

  @override
  _AttractionPageState createState() => _AttractionPageState();
}

class _AttractionPageState extends State<AttractionPage> {
  AttractionPageStyles _attractionPageStyles;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _attractionPageStyles = AttractionPageMobileStyles(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AttractionPageProvider(attractionModel: AttractionModel.fromJson(widget.attractionModel.toJson()))),
      ],
      child: Builder(builder: (context) {
        return _containerMain(context);
      }),
    );
  }

  Widget _containerMain(BuildContext context) {
    return Consumer<AttractionPageProvider>(builder: (context, attractionPageProvider, _) {
      if (attractionPageProvider.progressState != 1 && KeicyProgressDialog.of(context).isShowing()) {}

      if (attractionPageProvider.progressState == 2) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          await KeicyProgressDialog.of(context).hide();
          Navigator.of(context).pop();
        });
      } else {
        KeicyProgressDialog.of(context).hide();
      }

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        if (widget.isNew) {
          if (attractionPageProvider.attractionModel.name != "" &&
              attractionPageProvider.attractionModel.description != "" &&
              attractionPageProvider.imageFile != null) {
            attractionPageProvider.setSavePossible(true);
          } else {
            attractionPageProvider.setSavePossible(false);
          }
        } else {
          if ((attractionPageProvider.attractionModel.name != widget.attractionModel.name &&
                  (attractionPageProvider.imageFile != null || attractionPageProvider.attractionModel.imageUrl != "")) ||
              (attractionPageProvider.attractionModel.description != widget.attractionModel.description &&
                  (attractionPageProvider.imageFile != null || attractionPageProvider.attractionModel.imageUrl != "")) ||
              (attractionPageProvider.imageFile != null && attractionPageProvider.attractionModel.imageUrl != widget.attractionModel.imageUrl)) {
            attractionPageProvider.setSavePossible(true);
          } else {
            attractionPageProvider.setSavePossible(false);
          }
        }
      });

      return Scaffold(
        backgroundColor: AttractionPageColors.backColor,
        appBar: _containerAppBar(context, attractionPageProvider),
        body: _containerBody(context, attractionPageProvider),
      );
    });
  }

  Widget _containerAppBar(BuildContext context, AttractionPageProvider attractionPageProvider) {
    return PreferredSize(
      preferredSize: Size(_attractionPageStyles.deviceWidth, _attractionPageStyles.asamiAppbarHeight),
      child: Container(
        padding: EdgeInsets.all(_attractionPageStyles.asamiAppbarBottomPadding),
        alignment: Alignment.bottomCenter,
        color: AppColors.appbarColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    child: Icon(Icons.arrow_back_ios, size: _attractionPageStyles.iconSize, color: Colors.white),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    (!widget.isNew && attractionPageProvider.attractionModel.name != "")
                        ? attractionPageProvider.attractionModel.name
                        : AttractionPageString.addAppbarTitle,
                    style: TextStyle(
                      fontSize: _attractionPageStyles.appbarTitleFontSize,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    child: Text(
                      AttractionPageString.saveLabel,
                      style: TextStyle(
                        fontSize: _attractionPageStyles.appbarSaveTextFontSize,
                        color: (attractionPageProvider.savePossible) ? Colors.white : Colors.white.withAlpha(50),
                      ),
                    ),
                    onTap: () {
                      if (attractionPageProvider.savePossible) _saveHandler(context, attractionPageProvider);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _containerBody(BuildContext context, AttractionPageProvider attractionPageProvider) {
    return SingleChildScrollView(
      child: Form(
        key: _formkey,
        child: Container(
          width: _attractionPageStyles.deviceWidth,
          padding: EdgeInsets.symmetric(
            horizontal: _attractionPageStyles.primaryHorizontalPadding,
            vertical: _attractionPageStyles.primaryVerticalPadding,
          ),
          child: Column(
            children: <Widget>[
              /// image
              Container(
                width: double.infinity,
                height: _attractionPageStyles.imageHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_attractionPageStyles.widthDp * 10),
                  color: Colors.white,
                ),
                child: (attractionPageProvider.imageFile == null && attractionPageProvider.attractionModel.imageUrl == "")
                    ? Center(
                        child: Text(
                          attractionPageProvider.imageErrorString,
                          style: TextStyle(fontSize: _attractionPageStyles.fontSp * 15, color: Colors.red),
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(_attractionPageStyles.widthDp * 10),
                        child: (attractionPageProvider.imageFile != null)
                            ? Image.file(
                                attractionPageProvider.imageFile,
                                width: double.infinity,
                                height: _attractionPageStyles.imageHeight,
                                fit: BoxFit.cover,
                              )
                            : KeicyNetworkImage(
                                url: attractionPageProvider.attractionModel.imageUrl,
                                width: double.infinity,
                                height: _attractionPageStyles.imageHeight,
                              ),
                      ),
              ),

              /// picker Tool
              SizedBox(height: _attractionPageStyles.widthDp * 10),
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      (attractionPageProvider.imageFile == null && attractionPageProvider.attractionModel.imageUrl == "")
                          ? SizedBox()
                          : GestureDetector(
                              child: Icon(Icons.close, size: _attractionPageStyles.iconSize, color: Colors.white),
                              onTap: () {
                                attractionPageProvider.attractionModel.imageUrl = "";
                                attractionPageProvider.setImageFile(null);
                              },
                            ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: Icon(Icons.photo_library, size: _attractionPageStyles.iconSize, color: Colors.white),
                        onTap: () {
                          _imagePicker(context, attractionPageProvider, 0);
                        },
                      ),
                      SizedBox(width: _attractionPageStyles.widthDp * 30),
                      GestureDetector(
                        child: Icon(Icons.camera_alt, size: _attractionPageStyles.iconSize, color: Colors.white),
                        onTap: () {
                          _imagePicker(context, attractionPageProvider, 1);
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: _attractionPageStyles.widthDp * 10),

              /// name TextField
              SizedBox(height: _attractionPageStyles.itemSpacing),
              KeicyTextFormField(
                width: double.infinity,
                height: _attractionPageStyles.nameTextFieldHeight,
                initialValue: attractionPageProvider.attractionModel.name,
                textFontSize: _attractionPageStyles.textFontSize,
                borderRadius: _attractionPageStyles.widthDp * 6,
                border: Border.all(width: 1, color: Colors.white),
                errorBorder: Border.all(color: Colors.white),
                hintText: AttractionPageString.nameHint,
                contentHorizontalPadding: _attractionPageStyles.widthDp * 10,
                onChangeHandler: (input) {
                  attractionPageProvider.attractionModel.name = input.trim();
                  attractionPageProvider.setAttractionModel(attractionPageProvider.attractionModel);
                },
                validatorHandler: (input) => (input.length < 3) ? ValidateErrorString.textlengthErrorText.replaceAll("{length}", "3") : null,
                onSaveHandler: (input) => attractionPageProvider.attractionModel.name = input.trim(),
              ),

              /// description TextField
              SizedBox(height: _attractionPageStyles.itemSpacing),
              KeicyTextFormField(
                width: double.infinity,
                height: _attractionPageStyles.descriptionTextFieldHeight,
                initialValue: attractionPageProvider.attractionModel.description,
                textFontSize: _attractionPageStyles.textFontSize,
                hintText: AttractionPageString.descriptionHint,
                borderRadius: _attractionPageStyles.widthDp * 6,
                border: Border.all(width: 1, color: Colors.white),
                errorBorder: Border.all(color: Colors.white),
                contentHorizontalPadding: _attractionPageStyles.widthDp * 10,
                contentVerticalPadding: _attractionPageStyles.widthDp * 10,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                onChangeHandler: (input) {
                  attractionPageProvider.attractionModel.description = input.trim();
                  attractionPageProvider.setAttractionModel(attractionPageProvider.attractionModel);
                },
                validatorHandler: (input) => (input.length < 10) ? ValidateErrorString.textlengthErrorText.replaceAll("{length}", "10") : null,
                onSaveHandler: (input) => attractionPageProvider.attractionModel.description = input.trim(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _imagePicker(BuildContext context, AttractionPageProvider attractionPageProvider, int category) async {
    File _file;
    PickedFile _pickedFile;
    String _filePath;

    _pickedFile = await ImagePicker().getImage(source: (category == 0) ? ImageSource.gallery : ImageSource.camera);
    if (_pickedFile == null) return;

    _file = File(_pickedFile.path);
    attractionPageProvider.attractionModel.imageUrl = "";
    attractionPageProvider.setImageFile(_file);
  }

  void _saveHandler(BuildContext context, AttractionPageProvider attractionPageProvider) async {
    if (!_formkey.currentState.validate()) return;
    _formkey.currentState.save();

    await KeicyProgressDialog.of(context).show();
    attractionPageProvider.setProgressState(1, isNotifiable: false);
    if (widget.isNew)
      attractionPageProvider.addAttractionHandler();
    else
      attractionPageProvider.updateAttractionHandler(oldImagePath: widget.attractionModel.imageUrl);
  }
}
