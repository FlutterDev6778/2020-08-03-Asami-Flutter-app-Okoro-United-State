import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:asami_backend/Config/index.dart';

class MemberDetailPageStyles {
  double devicePixelRatio;
  double deviceWidth;
  double deviceHeight;
  double statusbarHeight;
  double bottombarHeight;
  double appbarHeight;
  double safeAreaHeight;
  double shareWidth;
  double shareHeight;
  double widthDp;
  double heightDp;
  double fontSp;

  double primaryHorizontalPadding;
  double primaryVerticalPadding;
  double asamiAppbarHeight;
  double asamiAppbarBottomPadding;
  double appbarTitleFontSize;

  double userInfoPanelHeight;
  double avatarSize;
  double userNameFontSize;
  double emailFontSize;
  double otherUserInfoFontSize;

  double textFontSize;
  double timeFontSize;
  double iconSize;

  double imageHeight;
  double imageWidth;

  MemberDetailPageStyles(BuildContext context) {}
}

class MemberDetailPageMobileStyles extends MemberDetailPageStyles {
  MemberDetailPageMobileStyles(BuildContext context) : super(context) {
    ScreenUtil.init(
      context,
      width: ResponsiveDesignSettings.mobileDesignWidth,
      height: ResponsiveDesignSettings.mobileDesignHeight,
      allowFontScaling: false,
    );

    devicePixelRatio = ScreenUtil.pixelRatio;
    deviceWidth = ScreenUtil.screenWidth;
    deviceHeight = ScreenUtil.screenHeight;
    statusbarHeight = ScreenUtil.statusBarHeight;
    appbarHeight = AppBar().preferredSize.height;
    bottombarHeight = ScreenUtil.bottomBarHeight;
    safeAreaHeight = deviceHeight - appbarHeight - statusbarHeight - bottombarHeight;
    shareWidth = deviceWidth / 100;
    shareHeight = deviceHeight / 100;
    widthDp = ScreenUtil().setWidth(1);
    heightDp = ScreenUtil().setHeight(1);
    fontSp = ScreenUtil().setSp(1, allowFontScalingSelf: false);

    primaryHorizontalPadding = widthDp * 17;
    primaryVerticalPadding = widthDp * 17;
    asamiAppbarHeight = widthDp * 101;
    asamiAppbarBottomPadding = widthDp * 22;
    appbarTitleFontSize = fontSp * 24;

    userInfoPanelHeight = widthDp * 270;
    avatarSize = widthDp * 100;
    userNameFontSize = fontSp * 26;
    emailFontSize = fontSp * 20;
    otherUserInfoFontSize = fontSp * 14;

    textFontSize = fontSp * 20;
    timeFontSize = fontSp * 16;
    iconSize = widthDp * 25;

    imageHeight = widthDp * 160;
    imageWidth = widthDp * 220;
  }
}
