import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:asami_backend/Config/index.dart';

class PromoCodePageStyles {
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

  double windowWidth;
  double windowHeight;
  double primaryHorizontalPadding;
  double primaryVerticalPadding;

  double titleFontSize;
  double textFontSize;

  double itemSpacing;
  double textFieldHeight;
  double descriptionFieldHeight;

  double buttonWidth;
  double buttonHeight;
  double buttonTextFontSize;

  PromoCodePageStyles(BuildContext context) {}
}

class PromoCodePageMobileStyles extends PromoCodePageStyles {
  PromoCodePageMobileStyles(BuildContext context) : super(context) {
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

    windowWidth = deviceWidth * 0.8;
    windowHeight = windowWidth * 1.4;
    primaryHorizontalPadding = widthDp * 15;
    primaryVerticalPadding = widthDp * 15;

    titleFontSize = fontSp * 20;
    textFontSize = fontSp * 15;

    itemSpacing = widthDp * 10;
    textFieldHeight = widthDp * 40;
    descriptionFieldHeight = widthDp * 100;

    buttonWidth = widthDp * 240;
    buttonHeight = widthDp * 40;
    buttonTextFontSize = fontSp * 20;
  }
}
