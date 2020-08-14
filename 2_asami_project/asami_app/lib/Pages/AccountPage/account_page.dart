import 'dart:async';

import 'package:asami_app/Pages/PrivacyPage/privacy_page.dart';
import 'package:asami_app/Pages/TermsPage/terms_page.dart';
import 'package:flutter/material.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keicy_progress_dialog/keicy_progress_dialog.dart';
import 'package:keicy_raised_button/keicy_raised_button.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:keicy_network_image/keicy_network_image.dart';

import 'index.dart';
import 'package:asami_app/Pages/App/index.dart';
import 'package:asami_app/Pages/EditProfilePage/edit_profile_page.dart';
import 'package:asami_app/Pages/TeaClubPage/tea_club_page.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> with TickerProviderStateMixin {
  AccountPageStyles _accountPageStyles;
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _accountPageStyles = AccountPageMobileStyles(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AccountPageProvider()),
      ],
      child: Builder(builder: (context) {
        return _containerMain(context);
      }),
    );
  }

  Widget _containerMain(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(_accountPageStyles.deviceWidth, _accountPageStyles.asamiAppbarHeight),
        child: Container(
          padding: EdgeInsets.all(_accountPageStyles.asamiAppbarBottomPadding),
          alignment: Alignment.bottomCenter,
          color: AppColors.appbarColor,
          child: Text(
            AccountPageString.appbarTitle,
            style: TextStyle(
              fontSize: _accountPageStyles.appbarTitleFontSize,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Container(
        width: _accountPageStyles.deviceWidth,
        height: _accountPageStyles.safeAreaHeight,
        padding: EdgeInsets.symmetric(
          horizontal: _accountPageStyles.primaryHorizontalPadding,
          vertical: _accountPageStyles.primaryVerticalPadding,
        ),
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _containerAvatarContainer(context),
            Expanded(child: _contanerItemList(context)),
          ],
        ),
      ),
    );
  }

  Widget _containerAvatarContainer(BuildContext context) {
    return Container(
      width: _accountPageStyles.deviceWidth,
      height: _accountPageStyles.avatarContainerHeight,
      color: AccountPageColors.backColor,
      padding: EdgeInsets.symmetric(
        horizontal: _accountPageStyles.avatarContainerHorizontalPadding,
        vertical: _accountPageStyles.avatarContainerVerticalPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: _accountPageStyles.avatarContainerItemSpacing),
          KeicyNetworkImage(
            url: AuthProvider.of(context).userModel.avatarUrl,
            width: _accountPageStyles.avatarImageSize,
            height: _accountPageStyles.avatarImageSize,
            borderRadius: _accountPageStyles.avatarImageSize / 2,
            borderColor: AccountPageColors.backColor,
            errorWidget: ClipRRect(
              borderRadius: BorderRadius.circular(_accountPageStyles.avatarImageSize / 2),
              child: Image.asset(
                AppAssets.avatarImage,
                width: _accountPageStyles.avatarImageSize,
                height: _accountPageStyles.avatarImageSize,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            AuthProvider.of(context).userModel.name,
            style: TextStyle(
              fontSize: _accountPageStyles.textFontSize,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  Widget _contanerItemList(BuildContext ocntext) {
    return Container(
      width: _accountPageStyles.deviceWidth,
      padding: EdgeInsets.symmetric(
        horizontal: _accountPageStyles.itemListHorizontalPadding,
        vertical: _accountPageStyles.itemListVerticalPadding,
      ),
      child: ListView.separated(
        itemCount: AccountPageString.itemList.length,
        itemBuilder: (context, index) {
          Function onPressHandler = () {};
          Widget icon = Icon(
            Icons.person,
            size: _accountPageStyles.iconSize,
            color: Colors.white,
          );
          switch (index) {
            case 0:
              onPressHandler = () {
                pushNewScreen(context, screen: EditProfilePage(), withNavBar: true);
              };
              icon = Icon(Icons.person, size: _accountPageStyles.iconSize);
              break;
            case 1:
              onPressHandler = () {
                pushNewScreen(context, screen: TeaClubPage(), withNavBar: true);
              };
              icon = FaIcon(FontAwesomeIcons.mugHot, size: _accountPageStyles.iconSize);
              break;
            case 2:
              icon = Icon(Icons.help, size: _accountPageStyles.iconSize);
              onPressHandler = () {
                pushNewScreen(context, screen: TermsPage(), withNavBar: true);
              };
              break;
            case 3:
              icon = Icon(Icons.list, size: _accountPageStyles.iconSize);
              onPressHandler = () {
                pushNewScreen(context, screen: PrivacyPage(), withNavBar: true);
              };
              break;
            case 4:
              icon = Icon(Icons.lock_outline, size: _accountPageStyles.iconSize);
              break;
            default:
          }
          return KeicyRaisedButton(
            width: double.infinity,
            height: _accountPageStyles.itemHeight,
            borderColor: Colors.black87,
            borderRadius: _accountPageStyles.widthDp * 5,
            borderWidth: 2,
            padding: EdgeInsets.symmetric(horizontal: _accountPageStyles.itemListHorizontalPadding),
            child: Row(
              children: <Widget>[
                icon,
                SizedBox(width: _accountPageStyles.itemListHorizontalPadding),
                Text(
                  AccountPageString.itemList[index],
                  style: TextStyle(
                    fontSize: _accountPageStyles.textFontSize,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            onPressed: onPressHandler,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: _accountPageStyles.itemListVerticalPadding);
        },
      ),
    );
  }
}
