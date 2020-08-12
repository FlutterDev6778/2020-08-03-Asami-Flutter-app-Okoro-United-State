import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Config/index.dart';

class MapViewPageStyles {
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

  double logoImageWidth;

  /// sliding panel
  double slidingPanelMaxHeight;
  double slidinghorizontalPadding;
  double slidingVerticalPadding;
  double tapLineWidth;
  double itemTitleFontSize;
  double explorerFontSize;
  double itemNameFontSize;
  double itemWidth;
  double itemHeight;

  MapViewPageStyles(BuildContext context) {}
}

class MapViewPageMobileStyles extends MapViewPageStyles {
  MapViewPageMobileStyles(BuildContext context) : super(context) {
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

    primaryHorizontalPadding = widthDp * 0;
    primaryVerticalPadding = widthDp * 0;
    asamiAppbarHeight = widthDp * 101;
    asamiAppbarBottomPadding = widthDp * 15;
    appbarTitleFontSize = fontSp * 30;
    safeAreaHeight = safeAreaHeight - asamiAppbarHeight - kBottomNavigationBarHeight;

    logoImageWidth = widthDp * 150;

    /// sliding panle
    slidingPanelMaxHeight = widthDp * 255;
    slidinghorizontalPadding = widthDp * 10;
    slidingVerticalPadding = widthDp * 20;
    tapLineWidth = widthDp * 95;
    itemTitleFontSize = fontSp * 25;
    explorerFontSize = fontSp * 18;
    itemNameFontSize = fontSp * 16;
    itemWidth = widthDp * 116;
    itemHeight = widthDp * 137;
  }
}
