import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:asami_backend/Config/index.dart';

class HerbDetailPageStyles {
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

  double titleFontSize;
  double textFontSize;

  double blendHeaderHeight;
  double blendItemHeight;

  HerbDetailPageStyles(BuildContext context) {}
}

class HerbDetailPageMobileStyles extends HerbDetailPageStyles {
  HerbDetailPageMobileStyles(BuildContext context) : super(context) {
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
    primaryVerticalPadding = widthDp * 15;
    asamiAppbarHeight = widthDp * 272;
    asamiAppbarHorizontalPadding = widthDp * 20;
    asamiAppbarTopPadding = statusbarHeight + widthDp * 20;
    asamiAppbarBottomPadding = widthDp * 35;
    safeAreaHeight = safeAreaHeight - asamiAppbarHeight;
    iconSize = widthDp * 30;

    titleFontSize = fontSp * 36;
    textFontSize = fontSp * 18;

    blendHeaderHeight = widthDp * 80;
    blendItemHeight = widthDp * 45;
  }
}
