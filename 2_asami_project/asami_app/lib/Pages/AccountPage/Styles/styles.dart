import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:asami_backend/Config/index.dart';

class AccountPageStyles {
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

  double avatarImageSize;
  double avatarContainerHeight;
  double avatarContainerHorizontalPadding;
  double avatarContainerVerticalPadding;
  double avatarContainerItemSpacing;

  double textFontSize;
  double iconSize;

  double itemListHorizontalPadding;
  double itemListVerticalPadding;
  double itemHeight;

  AccountPageStyles(BuildContext context) {}
}

class AccountPageMobileStyles extends AccountPageStyles {
  AccountPageMobileStyles(BuildContext context) : super(context) {
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
    asamiAppbarHeight = widthDp * 50;
    asamiAppbarBottomPadding = widthDp * 10;
    appbarTitleFontSize = fontSp * 25;
    safeAreaHeight = safeAreaHeight - asamiAppbarHeight - kBottomNavigationBarHeight;

    avatarImageSize = widthDp * 130;
    avatarContainerHeight = widthDp * 220;
    avatarContainerHorizontalPadding = widthDp * 20;
    avatarContainerVerticalPadding = widthDp * 20;
    avatarContainerItemSpacing = widthDp * 10;

    textFontSize = fontSp * 20;
    iconSize = widthDp * 32;
    itemListHorizontalPadding = widthDp * 20;
    itemListVerticalPadding = widthDp * 20;
    itemHeight = widthDp * 60;
  }
}
