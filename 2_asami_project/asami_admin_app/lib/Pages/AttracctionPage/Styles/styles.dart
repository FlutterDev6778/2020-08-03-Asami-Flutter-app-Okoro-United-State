import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:asami_backend/Config/index.dart';

class AttractionPageStyles {
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
  double appbarSaveTextFontSize;

  double textFontSize;
  double iconSize;

  double imageHeight;
  double nameTextFieldHeight;
  double descriptionTextFieldHeight;
  double itemSpacing;

  AttractionPageStyles(BuildContext context) {}
}

class AttractionPageMobileStyles extends AttractionPageStyles {
  AttractionPageMobileStyles(BuildContext context) : super(context) {
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

    primaryHorizontalPadding = widthDp * 23;
    primaryVerticalPadding = widthDp * 21;
    asamiAppbarHeight = widthDp * 50;
    asamiAppbarBottomPadding = widthDp * 10;
    appbarTitleFontSize = fontSp * 24;
    appbarSaveTextFontSize = fontSp * 20;
    safeAreaHeight = safeAreaHeight - asamiAppbarHeight;

    textFontSize = fontSp * 20;
    iconSize = widthDp * 30;

    imageHeight = widthDp * 235;
    nameTextFieldHeight = widthDp * 65;
    descriptionTextFieldHeight = widthDp * 228;
    itemSpacing = widthDp * 25;
  }
}
