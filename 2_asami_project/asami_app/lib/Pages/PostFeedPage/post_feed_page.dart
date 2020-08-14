import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:keicy_progress_dialog/keicy_progress_dialog.dart';
import 'package:keicy_text_form_field/keicy_text_form_field.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:image_picker/image_picker.dart';

import 'index.dart';
import 'package:asami_app/Pages/App/index.dart';

class PostFeedPage extends StatefulWidget {
  @override
  _PostFeedPageState createState() => _PostFeedPageState();
}

class _PostFeedPageState extends State<PostFeedPage> {
  PostFeedPageStyles _postFeedPageStyles;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _postFeedPageStyles = PostFeedPageMobileStyles(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostFeedPageProvider()),
      ],
      child: Builder(builder: (context) {
        return _containerMain(context);
      }),
    );
  }

  Widget _containerMain(BuildContext context) {
    PostFeedPageProvider.of(context).addListener(() {
      if (PostFeedPageProvider.of(context).loadingState != 1 && KeicyProgressDialog.of(context).isShowing()) {
        KeicyProgressDialog.of(context).hide();
      }

      if (PostFeedPageProvider.of(context).loadingState == -1) {
        PostFeedPageProvider.of(context).setLoadingState(0);
      } else if (PostFeedPageProvider.of(context).loadingState == 2) {
        PostFeedPageProvider.of(context).setLoadingState(0);
        PostFeedPageProvider.of(context).setImageFile(null);
        _textEditingController.clear();
      }
    });

    return Consumer<PostFeedPageProvider>(builder: (context, postFeedPageProvider, _) {
      return Scaffold(
        body: Scaffold(
          backgroundColor: PostFeedPageColors.backColor,
          appBar: PreferredSize(
            preferredSize: Size(_postFeedPageStyles.deviceWidth, _postFeedPageStyles.asamiAppbarHeight),
            child: Container(
              padding: EdgeInsets.all(_postFeedPageStyles.asamiAppbarBottomPadding),
              alignment: Alignment.bottomCenter,
              color: AppColors.appbarColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    child: Icon(Icons.arrow_back_ios, size: _postFeedPageStyles.iconSize, color: Colors.white),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Text(
                    PostFeedPageString.appbarTitle,
                    style: TextStyle(
                      fontSize: _postFeedPageStyles.appbarTitleFontSize,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    child: Icon(Icons.send,
                        size: _postFeedPageStyles.iconSize,
                        color: (_textEditingController.text != "" && postFeedPageProvider.imageFile != null)
                            ? Colors.white
                            : Colors.white.withAlpha(100)),
                    onTap: () async {
                      if (_textEditingController.text == "" || postFeedPageProvider.imageFile == null) return;
                      await KeicyProgressDialog.of(context).show();
                      postFeedPageProvider.setLoadingState(1);
                      postFeedPageProvider.postFeed(
                        description: _textEditingController.text,
                        userModel: AuthProvider.of(context).userModel,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              width: _postFeedPageStyles.deviceWidth,
              height: _postFeedPageStyles.safeAreaHeight,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: _postFeedPageStyles.primaryHorizontalPadding,
                        vertical: _postFeedPageStyles.primaryVerticalPadding,
                      ),
                      child: KeicyTextFormField(
                        width: double.infinity,
                        height: null,
                        controller: _textEditingController,
                        fixedHeightState: false,
                        fillColor: Colors.transparent,
                        textFontSize: _postFeedPageStyles.textFontSize,
                        textColor: Colors.white,
                        hintText: PostFeedPageString.contentsHint,
                        hintTextColor: Colors.white.withAlpha(120),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        border: Border.all(width: 0, color: Colors.transparent),
                      ),
                    ),
                  ),
                  (postFeedPageProvider.imageFile == null)
                      ? SizedBox()
                      : Image.file(
                          postFeedPageProvider.imageFile,
                          width: _postFeedPageStyles.deviceWidth,
                          height: (_postFeedPageStyles.deviceWidth) * 0.7,
                          fit: BoxFit.cover,
                        ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            width: _postFeedPageStyles.deviceWidth,
            height: _postFeedPageStyles.imagePickerHeight,
            color: PostFeedPageColors.imagePicker,
            padding: EdgeInsets.symmetric(
              horizontal: _postFeedPageStyles.widthDp * 27,
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      child: Icon(Icons.camera_alt, size: _postFeedPageStyles.iconSize, color: Colors.black),
                      onTap: () async {
                        PickedFile pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
                        if (pickedFile == null) return;
                        postFeedPageProvider.setImageFile(File(pickedFile.path));
                      },
                    ),
                    SizedBox(width: _postFeedPageStyles.widthDp * 30),
                    GestureDetector(
                      child: Icon(Icons.photo_library, size: _postFeedPageStyles.iconSize, color: Colors.black),
                      onTap: () async {
                        PickedFile pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
                        if (pickedFile == null) return;
                        postFeedPageProvider.setImageFile(File(pickedFile.path));
                      },
                    ),
                  ],
                ),
                (postFeedPageProvider.imageFile == null)
                    ? SizedBox()
                    : Row(
                        children: <Widget>[
                          Text(
                            "File selected",
                            style: TextStyle(fontSize: _postFeedPageStyles.textFontSize),
                          ),
                          SizedBox(width: _postFeedPageStyles.widthDp * 20),
                          GestureDetector(
                            child: Icon(Icons.close, size: _postFeedPageStyles.iconSize, color: Colors.black),
                            onTap: () {
                              postFeedPageProvider.setImageFile(null);
                            },
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
