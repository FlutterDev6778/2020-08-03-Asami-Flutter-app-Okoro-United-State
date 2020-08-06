import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:asami_app/Pages/App/Config/index.dart';

class FeedListPageStyles {
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

  double feedHorizontalPadding;
  double feedVerticalPadding;
  double feedTitleFontSize;
  double feedDescriptionFontSize;
  double feedDateTimeFontSize;
  double feedAvatarSize;
  double feedSpacing;
  double feedImageWidth;
  double feedImageHeight;

  double floatingButtonSize;

  FeedListPageStyles(BuildContext context) {}
}

class FeedListPageMobileStyles extends FeedListPageStyles {
  FeedListPageMobileStyles(BuildContext context) : super(context) {
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
    safeAreaHeight = deviceHeight - asamiAppbarHeight - kBottomNavigationBarHeight;

    feedHorizontalPadding = widthDp * 15;
    feedVerticalPadding = widthDp * 15;
    feedTitleFontSize = fontSp * 23;
    feedDescriptionFontSize = fontSp * 20;
    feedDateTimeFontSize = fontSp * 18;
    feedAvatarSize = widthDp * 75;
    feedSpacing = widthDp * 22;
    feedImageWidth = widthDp * 275;
    feedImageHeight = widthDp * 200;

    floatingButtonSize = widthDp * 40;
  }
}
