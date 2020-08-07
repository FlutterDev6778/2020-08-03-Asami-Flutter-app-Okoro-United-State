import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:asami_app/Pages/App/Config/index.dart';

class TeaClubPageStyles {
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
  double appbarIconSize;

  double avatarImageSize;
  double avatarContainerHeight;
  double avatarContainerHorizontalPadding;
  double avatarContainerVerticalPadding;
  double avatarContainerItemSpacing;

  double imageWidth;
  double imageHeight;

  double textFontSize;
  double buttonHeight;

  double itemSpacing;

  TeaClubPageStyles(BuildContext context) {}
}

class TeaClubPageMobileStyles extends TeaClubPageStyles {
  TeaClubPageMobileStyles(BuildContext context) : super(context) {
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
    primaryVerticalPadding = widthDp * 35;
    asamiAppbarHeight = widthDp * 101;
    asamiAppbarBottomPadding = widthDp * 22;
    appbarTitleFontSize = fontSp * 30;
    appbarIconSize = widthDp * 20;
    safeAreaHeight = deviceHeight - asamiAppbarHeight - kBottomNavigationBarHeight;

    avatarImageSize = widthDp * 130;
    avatarContainerHeight = widthDp * 220;
    avatarContainerHorizontalPadding = widthDp * 20;
    avatarContainerVerticalPadding = widthDp * 20;
    avatarContainerItemSpacing = widthDp * 10;

    imageWidth = widthDp * 114;
    imageHeight = widthDp * 86;

    textFontSize = fontSp * 20;
    buttonHeight = widthDp * 60;

    itemSpacing = widthDp * 18;
  }
}
