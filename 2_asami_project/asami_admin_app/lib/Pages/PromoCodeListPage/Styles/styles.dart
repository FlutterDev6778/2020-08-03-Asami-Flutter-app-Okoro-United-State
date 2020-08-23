import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:asami_backend/Config/index.dart';

class PromoCodeListPageStyles {
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

  double titleFontSize;
  double codeFontSize;
  double descriptionFontSize;
  double iconSize;

  double promoCodeItemHeight;
  double promoCodeItemHorizontalPadding;
  double promoCodeItemVerticalPadding;

  double addButtonHeight;

  PromoCodeListPageStyles(BuildContext context) {}
}

class PromoCodeListPageMobileStyles extends PromoCodeListPageStyles {
  PromoCodeListPageMobileStyles(BuildContext context) : super(context) {
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

    primaryHorizontalPadding = widthDp * 17;
    primaryVerticalPadding = widthDp * 22;
    asamiAppbarHeight = widthDp * 50;
    asamiAppbarBottomPadding = widthDp * 10;
    appbarTitleFontSize = fontSp * 24;
    safeAreaHeight = safeAreaHeight - asamiAppbarHeight;

    titleFontSize = fontSp * 24;
    codeFontSize = fontSp * 18;
    descriptionFontSize = fontSp * 14;
    iconSize = widthDp * 30;

    promoCodeItemHeight = widthDp * 133;
    promoCodeItemHorizontalPadding = widthDp * 20;
    promoCodeItemVerticalPadding = widthDp * 20;

    addButtonHeight = widthDp * 60;
  }
}
