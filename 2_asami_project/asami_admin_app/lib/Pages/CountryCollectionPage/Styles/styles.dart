import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:asami_backend/Config/index.dart';

class CountryCollectionPageStyles {
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
  double asamiAppbarHorizontalPadding;
  double asamiAppbarTopPadding;
  double asamiAppbarBottomPadding;
  double iconSize;
  double appbarTitleFontSize;

  double titleFontSize;
  double textFontSize;

  double addItemHeight;

  double itemHeight;
  double itemHorizontalMargin;
  double itemHorizontalPadding;
  double itemVerticalSpacing;
  double itemImageSize;

  CountryCollectionPageStyles(BuildContext context) {}
}

class CountryCollectionPageMobileStyles extends CountryCollectionPageStyles {
  CountryCollectionPageMobileStyles(BuildContext context) : super(context) {
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
    safeAreaHeight = deviceHeight - statusbarHeight;
    shareWidth = deviceWidth / 100;
    shareHeight = deviceHeight / 100;
    widthDp = ScreenUtil().setWidth(1);
    heightDp = ScreenUtil().setHeight(1);
    fontSp = ScreenUtil().setSp(1, allowFontScalingSelf: false);

    primaryHorizontalPadding = widthDp * 20;
    primaryVerticalPadding = widthDp * 0;
    asamiAppbarHeight = widthDp * 331 + kBottomNavigationBarHeight;
    asamiAppbarHorizontalPadding = widthDp * 20;
    asamiAppbarTopPadding = statusbarHeight + widthDp * 24;
    asamiAppbarBottomPadding = widthDp * 35;
    safeAreaHeight = safeAreaHeight - asamiAppbarHeight;
    iconSize = widthDp * 30;
    appbarTitleFontSize = fontSp * 24;

    titleFontSize = fontSp * 24;
    textFontSize = fontSp * 16;

    addItemHeight = widthDp * 68;
    itemHeight = widthDp * 104;
    itemHorizontalMargin = widthDp * 26;
    itemHorizontalPadding = widthDp * 8;
    itemVerticalSpacing = widthDp * 26;
    itemImageSize = widthDp * 70;
  }
}
