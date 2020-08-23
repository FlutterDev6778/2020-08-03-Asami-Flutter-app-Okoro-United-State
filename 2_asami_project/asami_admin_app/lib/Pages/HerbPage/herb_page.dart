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

class HerbPage extends StatefulWidget {
  HerbPage({@required HerbModel herbModel, bool isNew = false}) {
    this.isNew = isNew;
    this.herbModel = herbModel;
  }

  bool isNew;
  HerbModel herbModel;

  @override
  _HerbPageState createState() => _HerbPageState();
}

class _HerbPageState extends State<HerbPage> {
  HerbPageStyles _herbPageStyles;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _herbPageStyles = HerbPageMobileStyles(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HerbPageProvider(herbModel: HerbModel.fromJson(widget.herbModel.toJson()))),
      ],
      child: Builder(builder: (context) {
        return _containerMain(context);
      }),
    );
  }

  Widget _containerMain(BuildContext context) {
    return Consumer<HerbPageProvider>(builder: (context, herbPageProvider, _) {
      if (herbPageProvider.progressState != 1 && KeicyProgressDialog.of(context).isShowing()) {}

      if (herbPageProvider.progressState == 2) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          await KeicyProgressDialog.of(context).hide();
          Navigator.of(context).pop();
        });
      } else {
        KeicyProgressDialog.of(context).hide();
      }

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        if (widget.isNew) {
          if (herbPageProvider.herbModel.name != "" && herbPageProvider.herbModel.description != "" && herbPageProvider.imageFile != null) {
            herbPageProvider.setSavePossible(true);
          } else {
            herbPageProvider.setSavePossible(false);
          }
        } else {
          if ((herbPageProvider.herbModel.name != widget.herbModel.name &&
                  (herbPageProvider.imageFile != null || herbPageProvider.herbModel.imageUrl != "")) ||
              (herbPageProvider.herbModel.description != widget.herbModel.description &&
                  (herbPageProvider.imageFile != null || herbPageProvider.herbModel.imageUrl != "")) ||
              (herbPageProvider.imageFile != null && herbPageProvider.herbModel.imageUrl != widget.herbModel.imageUrl)) {
            herbPageProvider.setSavePossible(true);
          } else {
            herbPageProvider.setSavePossible(false);
          }
        }
      });

      return Scaffold(
        backgroundColor: HerbPageColors.backColor,
        appBar: _containerAppBar(context, herbPageProvider),
        body: _containerBody(context, herbPageProvider),
      );
    });
  }

  Widget _containerAppBar(BuildContext context, HerbPageProvider herbPageProvider) {
    return PreferredSize(
      preferredSize: Size(_herbPageStyles.deviceWidth, _herbPageStyles.asamiAppbarHeight),
      child: Container(
        padding: EdgeInsets.all(_herbPageStyles.asamiAppbarBottomPadding),
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
                    child: Icon(Icons.arrow_back_ios, size: _herbPageStyles.iconSize, color: Colors.white),
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
                    (!widget.isNew && herbPageProvider.herbModel.name != "") ? herbPageProvider.herbModel.name : HerbPageString.appbarTitle,
                    style: TextStyle(
                      fontSize: _herbPageStyles.appbarTitleFontSize,
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
                      HerbPageString.saveLabel,
                      style: TextStyle(
                        fontSize: _herbPageStyles.appbarSaveTextFontSize,
                        color: (herbPageProvider.savePossible) ? Colors.white : Colors.white.withAlpha(50),
                      ),
                    ),
                    onTap: () {
                      if (herbPageProvider.savePossible) _saveHandler(context, herbPageProvider);
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

  Widget _containerBody(BuildContext context, HerbPageProvider herbPageProvider) {
    return SingleChildScrollView(
      child: Form(
        key: _formkey,
        child: Container(
          width: _herbPageStyles.deviceWidth,
          padding: EdgeInsets.symmetric(
            horizontal: _herbPageStyles.primaryHorizontalPadding,
            vertical: _herbPageStyles.primaryVerticalPadding,
          ),
          child: Column(
            children: <Widget>[
              /// image
              Container(
                width: double.infinity,
                height: _herbPageStyles.imageHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_herbPageStyles.widthDp * 10),
                  color: Colors.white,
                ),
                child: (herbPageProvider.imageFile == null && herbPageProvider.herbModel.imageUrl == "")
                    ? Center(
                        child: Text(
                          herbPageProvider.imageErrorString,
                          style: TextStyle(fontSize: _herbPageStyles.fontSp * 15, color: Colors.red),
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(_herbPageStyles.widthDp * 10),
                        child: (herbPageProvider.imageFile != null)
                            ? Image.file(
                                herbPageProvider.imageFile,
                                width: double.infinity,
                                height: _herbPageStyles.imageHeight,
                                fit: BoxFit.cover,
                              )
                            : KeicyNetworkImage(
                                url: herbPageProvider.herbModel.imageUrl,
                                width: double.infinity,
                                height: _herbPageStyles.imageHeight,
                              ),
                      ),
              ),

              /// picker Tool
              SizedBox(height: _herbPageStyles.widthDp * 10),
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      (herbPageProvider.imageFile == null && herbPageProvider.herbModel.imageUrl == "")
                          ? SizedBox()
                          : GestureDetector(
                              child: Icon(Icons.close, size: _herbPageStyles.iconSize, color: Colors.white),
                              onTap: () {
                                herbPageProvider.herbModel.imageUrl = "";
                                herbPageProvider.setImageFile(null);
                              },
                            ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: Icon(Icons.photo_library, size: _herbPageStyles.iconSize, color: Colors.white),
                        onTap: () {
                          _imagePicker(context, herbPageProvider, 0);
                        },
                      ),
                      SizedBox(width: _herbPageStyles.widthDp * 30),
                      GestureDetector(
                        child: Icon(Icons.camera_alt, size: _herbPageStyles.iconSize, color: Colors.white),
                        onTap: () {
                          _imagePicker(context, herbPageProvider, 1);
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: _herbPageStyles.widthDp * 10),

              /// name TextField
              SizedBox(height: _herbPageStyles.itemSpacing),
              KeicyTextFormField(
                width: double.infinity,
                height: _herbPageStyles.nameTextFieldHeight,
                initialValue: herbPageProvider.herbModel.name,
                textFontSize: _herbPageStyles.textFontSize,
                borderRadius: _herbPageStyles.widthDp * 6,
                border: Border.all(width: 1, color: Colors.white),
                errorBorder: Border.all(color: Colors.white),
                hintText: HerbPageString.nameHint,
                contentHorizontalPadding: _herbPageStyles.widthDp * 10,
                onChangeHandler: (input) {
                  herbPageProvider.herbModel.name = input.trim();
                  herbPageProvider.setHerbModel(herbPageProvider.herbModel);
                },
                validatorHandler: (input) => (input.length < 3) ? ValidateErrorString.textlengthErrorText.replaceAll("{length}", "3") : null,
                onSaveHandler: (input) => herbPageProvider.herbModel.name = input.trim(),
              ),

              /// description TextField
              SizedBox(height: _herbPageStyles.itemSpacing),
              KeicyTextFormField(
                width: double.infinity,
                height: _herbPageStyles.descriptionTextFieldHeight,
                initialValue: herbPageProvider.herbModel.description,
                textFontSize: _herbPageStyles.textFontSize,
                hintText: HerbPageString.descriptionHint,
                borderRadius: _herbPageStyles.widthDp * 6,
                border: Border.all(width: 1, color: Colors.white),
                errorBorder: Border.all(color: Colors.white),
                contentHorizontalPadding: _herbPageStyles.widthDp * 10,
                contentVerticalPadding: _herbPageStyles.widthDp * 10,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                onChangeHandler: (input) {
                  herbPageProvider.herbModel.description = input.trim();
                  herbPageProvider.setHerbModel(herbPageProvider.herbModel);
                },
                validatorHandler: (input) => (input.length < 10) ? ValidateErrorString.textlengthErrorText.replaceAll("{length}", "10") : null,
                onSaveHandler: (input) => herbPageProvider.herbModel.description = input.trim(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _imagePicker(BuildContext context, HerbPageProvider herbPageProvider, int category) async {
    File _file;
    PickedFile _pickedFile;
    String _filePath;

    _pickedFile = await ImagePicker().getImage(source: (category == 0) ? ImageSource.gallery : ImageSource.camera);
    if (_pickedFile == null) return;

    _file = File(_pickedFile.path);
    herbPageProvider.herbModel.imageUrl = "";
    herbPageProvider.setImageFile(_file);
  }

  void _saveHandler(BuildContext context, HerbPageProvider herbPageProvider) async {
    if (!_formkey.currentState.validate()) return;
    _formkey.currentState.save();

    await KeicyProgressDialog.of(context).show();
    herbPageProvider.setProgressState(1, isNotifiable: false);
    if (widget.isNew)
      herbPageProvider.addHerbHandler();
    else
      herbPageProvider.updateHerbHandler(oldImagePath: widget.herbModel.imageUrl);
  }
}
