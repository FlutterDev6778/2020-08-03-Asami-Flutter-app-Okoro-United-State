import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:asami_backend/Config/index.dart';

class LoginPageStyles {
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

  double logo1ImageTop;
  double logo1ImageWidth;

  double textFontSize;
  double iconSize;

  double textFieldWidth;
  double textFieldHeight;

  double buttonWidth;
  double buttonHeight;

  LoginPageStyles(BuildContext context) {}
}

class LoginPageMobileStyles extends LoginPageStyles {
  LoginPageMobileStyles(BuildContext context) : super(context) {
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
    safeAreaHeight = deviceHeight - statusbarHeight - bottombarHeight;
    shareWidth = deviceWidth / 100;
    shareHeight = deviceHeight / 100;
    widthDp = ScreenUtil().setWidth(1);
    heightDp = ScreenUtil().setHeight(1);
    fontSp = ScreenUtil().setSp(1, allowFontScalingSelf: false);

    primaryHorizontalPadding = widthDp * 20;
    primaryVerticalPadding = widthDp * 20;

    logo1ImageWidth = widthDp * 352;
    logo1ImageTop = deviceHeight * 150 / ResponsiveDesignSettings.mobileDesignHeight;

    textFontSize = fontSp * 20;
    iconSize = widthDp * 25;

    textFieldWidth = widthDp * 300;
    textFieldHeight = widthDp * 45;

    buttonWidth = widthDp * 142;
    buttonHeight = widthDp * 45;
  }
}
