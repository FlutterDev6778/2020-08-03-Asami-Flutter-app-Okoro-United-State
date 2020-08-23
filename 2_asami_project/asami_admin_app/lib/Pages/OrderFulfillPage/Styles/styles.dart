import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:asami_backend/Config/index.dart';

class OrderFulfillPageStyles {
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
  double emailFontSize;
  double iconSize;

  double searchFieldHeight;

  double memberItemHeight;
  double memberItemHorizontalPadding;
  double avatarSize;

  OrderFulfillPageStyles(BuildContext context) {}
}

class OrderFulfillPageMobileStyles extends OrderFulfillPageStyles {
  OrderFulfillPageMobileStyles(BuildContext context) : super(context) {
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

    primaryHorizontalPadding = widthDp * 14;
    primaryVerticalPadding = widthDp * 23;
    asamiAppbarHeight = widthDp * 50;
    asamiAppbarBottomPadding = widthDp * 10;
    appbarTitleFontSize = fontSp * 24;
    safeAreaHeight = safeAreaHeight - asamiAppbarHeight;

    textFontSize = fontSp * 20;
    emailFontSize = fontSp * 16;
    iconSize = widthDp * 30;

    searchFieldHeight = widthDp * 47;

    memberItemHeight = widthDp * 92;
    memberItemHorizontalPadding = widthDp * 24;
    avatarSize = widthDp * 70;
  }
}
