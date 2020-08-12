import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Config/index.dart';

class PremiumPageStyles {
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

  double descriptionFontSiz;
  double textFontSize;
  double logoImageWidth;

  double itemSpacing;

  PremiumPageStyles(BuildContext context) {}
}

class PremiumPageMobileStyles extends PremiumPageStyles {
  PremiumPageMobileStyles(BuildContext context) : super(context) {
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

    primaryHorizontalPadding = widthDp * 50;
    primaryVerticalPadding = widthDp * 0;
    asamiAppbarHeight = widthDp * 101;
    asamiAppbarBottomPadding = widthDp * 22;
    appbarTitleFontSize = fontSp * 30;
    safeAreaHeight = deviceHeight - asamiAppbarHeight - kBottomNavigationBarHeight;

    descriptionFontSiz = fontSp * 20;
    textFontSize = fontSp * 25;
    logoImageWidth = widthDp * 200;

    itemSpacing = widthDp * 60;
  }
}
