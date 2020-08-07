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
import 'package:asami_app/Models/index.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> with TickerProviderStateMixin {
  EditProfilePageStyles _editProfilePageStyles;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _editProfilePageStyles = EditProfilePageMobileStyles(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EditProfilePageProvider()),
      ],
      child: _containerMain(context),
    );
  }

  Widget _containerMain(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(_editProfilePageStyles.deviceWidth, _editProfilePageStyles.asamiAppbarHeight),
          child: Container(
            padding: EdgeInsets.all(_editProfilePageStyles.asamiAppbarBottomPadding),
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
                    size: _editProfilePageStyles.appbarIconSize,
                    color: Colors.white,
                  ),
                ),
                Text(
                  EditProfilePageString.appbarTitle,
                  style: TextStyle(
                    fontSize: _editProfilePageStyles.appbarTitleFontSize,
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
                    size: _editProfilePageStyles.appbarIconSize,
                    color: AppColors.appbarColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: _editProfilePageStyles.deviceWidth,
            height: _editProfilePageStyles.safeAreaHeight,
            padding: EdgeInsets.symmetric(
              horizontal: _editProfilePageStyles.primaryHorizontalPadding,
              vertical: _editProfilePageStyles.primaryVerticalPadding,
            ),
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _containerAvatarContainer(context),
                SizedBox(height: _editProfilePageStyles.widthDp * 20),
                Expanded(child: _contanerForm(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _containerAvatarContainer(BuildContext context) {
    return Container(
      width: _editProfilePageStyles.deviceWidth,
      height: _editProfilePageStyles.avatarContainerHeight,
      color: EditProfilePageColors.backColor,
      padding: EdgeInsets.symmetric(
        horizontal: _editProfilePageStyles.avatarContainerHorizontalPadding,
        vertical: _editProfilePageStyles.avatarContainerVerticalPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: _editProfilePageStyles.avatarContainerItemSpacing),
          KeicyNetworkImage(
            url: AuthProvider.of(context).userModel.avatarUrl,
            width: _editProfilePageStyles.avatarImageSize,
            height: _editProfilePageStyles.avatarImageSize,
            borderRadius: _editProfilePageStyles.avatarImageSize / 2,
            borderColor: EditProfilePageColors.backColor,
          ),
          Text(
            AuthProvider.of(context).userModel.name,
            style: TextStyle(
              fontSize: _editProfilePageStyles.textFontSize,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  Widget _contanerForm(BuildContext ocntext) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          KeicyTextFormField(
            width: _editProfilePageStyles.deviceWidth,
            height: _editProfilePageStyles.textFieldHeight,
            initialValue: AuthProvider.of(context).userModel.name,
            prefixIcons: <Widget>[
              Text(
                EditProfilePageString.nameLabel,
                style: TextStyle(fontSize: _editProfilePageStyles.labelFontSize, color: AppColors.primaryColor, fontWeight: FontWeight.bold),
              )
            ],
            fixedHeightState: false,
            iconSpacing: _editProfilePageStyles.textFieldHorizontalPadding,
            contentHorizontalPadding: _editProfilePageStyles.textFieldHorizontalPadding,
            textFontSize: _editProfilePageStyles.textFontSize,
            hintText: EditProfilePageString.nameHint,
            border: Border(top: BorderSide(width: 1), bottom: BorderSide(width: 1)),
          ),
          KeicyTextFormField(
            width: _editProfilePageStyles.deviceWidth,
            height: _editProfilePageStyles.textFieldHeight,
            initialValue: AuthProvider.of(context).userModel.email,
            prefixIcons: <Widget>[
              Text(
                EditProfilePageString.emailLabel,
                style: TextStyle(fontSize: _editProfilePageStyles.labelFontSize, color: AppColors.primaryColor, fontWeight: FontWeight.bold),
              )
            ],
            iconSpacing: _editProfilePageStyles.textFieldHorizontalPadding,
            contentHorizontalPadding: _editProfilePageStyles.textFieldHorizontalPadding,
            textFontSize: _editProfilePageStyles.textFontSize,
            hintText: EditProfilePageString.emailHint,
            border: Border(bottom: BorderSide(width: 1)),
          ),
        ],
      ),
    );
  }
}
