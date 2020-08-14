import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:asami_backend/Config/index.dart';

class DashboardPageStyles {
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

  double textFontSize;
  double amountTextFontSize;

  double categoryWidth;
  double categoryHeight;
  double categoryHorizontalPadding;
  double categoryVerticalPadding;
  double categoryIconSize;

  DashboardPageStyles(BuildContext context) {}
}

class DashboardPageMobileStyles extends DashboardPageStyles {
  DashboardPageMobileStyles(BuildContext context) : super(context) {
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

    primaryHorizontalPadding = widthDp * 38;
    primaryVerticalPadding = widthDp * 30;
    asamiAppbarHeight = widthDp * 101;
    asamiAppbarBottomPadding = widthDp * 22;
    appbarTitleFontSize = fontSp * 24;
    safeAreaHeight = safeAreaHeight - asamiAppbarHeight;

    textFontSize = fontSp * 20;
    amountTextFontSize = fontSp * 50;

    categoryWidth = widthDp * 142;
    categoryHeight = widthDp * 131;
    categoryHorizontalPadding = widthDp * 12;
    categoryVerticalPadding = widthDp * 12;
    categoryIconSize = widthDp * 50;
  }
}
