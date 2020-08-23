import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:keicy_text_form_field/keicy_text_form_field.dart';
import 'package:provider/provider.dart';

import 'package:image_picker/image_picker.dart';

import 'index.dart';
import 'package:asami_admin_app/Pages/App/index.dart';

class PostNotificationPage extends StatefulWidget {
  @override
  _PostNotificationPageState createState() => _PostNotificationPageState();
}

class _PostNotificationPageState extends State<PostNotificationPage> {
  PostNotificationPageStyles _postNotificationPageStyles;
  TextEditingController _titleTextEditingController = TextEditingController();
  TextEditingController _descriptionTextEditingController = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _postNotificationPageStyles = PostNotificationPageMobileStyles(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostNotificationPageProvider()),
      ],
      child: Builder(builder: (context) {
        return _containerMain(context);
      }),
    );
  }

  Widget _containerMain(BuildContext context) {
    return Scaffold(
      backgroundColor: PostNotificationPageColors.backColor,
      appBar: PreferredSize(
        preferredSize: Size(_postNotificationPageStyles.deviceWidth, _postNotificationPageStyles.asamiAppbarHeight),
        child: Container(
          padding: EdgeInsets.all(_postNotificationPageStyles.asamiAppbarBottomPadding),
          alignment: Alignment.bottomCenter,
          color: AppColors.appbarColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                child: Icon(Icons.arrow_back_ios, size: _postNotificationPageStyles.iconSize, color: Colors.white),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              Text(
                PostNotificationPageString.appbarTitle,
                style: TextStyle(
                  fontSize: _postNotificationPageStyles.appbarTitleFontSize,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                child: Icon(Icons.send, size: _postNotificationPageStyles.iconSize, color: Colors.white),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Container(
            width: _postNotificationPageStyles.deviceWidth,
            height: _postNotificationPageStyles.safeAreaHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                KeicyTextFormField(
                  width: double.infinity,
                  height: _postNotificationPageStyles.titleTextFieldHeight,
                  controller: _titleTextEditingController,
                  fixedHeightState: false,
                  fillColor: Colors.transparent,
                  textFontSize: _postNotificationPageStyles.textFontSize,
                  textColor: Colors.white,
                  hintText: PostNotificationPageString.titleHint,
                  hintTextColor: Colors.white.withAlpha(120),
                  border: Border(bottom: BorderSide(width: 2, color: PostNotificationPageColors.titleTextBorder)),
                  contentHorizontalPadding: _postNotificationPageStyles.primaryHorizontalPadding,
                ),
                Expanded(
                  child: KeicyTextFormField(
                    width: double.infinity,
                    height: _postNotificationPageStyles.safeAreaHeight - _postNotificationPageStyles.titleTextFieldHeight,
                    controller: _descriptionTextEditingController,
                    fixedHeightState: false,
                    fillColor: Colors.transparent,
                    textFontSize: _postNotificationPageStyles.textFontSize,
                    textColor: Colors.white,
                    hintText: PostNotificationPageString.descriptionHint,
                    hintTextColor: Colors.white.withAlpha(120),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    border: Border.all(width: 0, color: Colors.transparent),
                    contentHorizontalPadding: _postNotificationPageStyles.primaryHorizontalPadding,
                    contentVerticalPadding: _postNotificationPageStyles.primaryVerticalPadding,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
