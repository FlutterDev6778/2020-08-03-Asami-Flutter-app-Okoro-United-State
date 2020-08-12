import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Config/index.dart';

class EditProfilePageStyles {
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

  double textFontSize;
  double labelFontSize;

  double textFieldHeight;
  double textFieldHorizontalPadding;

  EditProfilePageStyles(BuildContext context) {}
}

class EditProfilePageMobileStyles extends EditProfilePageStyles {
  EditProfilePageMobileStyles(BuildContext context) : super(context) {
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
    asamiAppbarBottomPadding = widthDp * 22;
    appbarTitleFontSize = fontSp * 30;
    appbarIconSize = widthDp * 20;
    safeAreaHeight = deviceHeight - asamiAppbarHeight - kBottomNavigationBarHeight;

    avatarImageSize = widthDp * 130;
    avatarContainerHeight = widthDp * 220;
    avatarContainerHorizontalPadding = widthDp * 20;
    avatarContainerVerticalPadding = widthDp * 20;
    avatarContainerItemSpacing = widthDp * 10;

    textFontSize = fontSp * 22;
    labelFontSize = fontSp * 24;

    textFieldHeight = widthDp * 65;
    textFieldHorizontalPadding = widthDp * 30;
  }
}
