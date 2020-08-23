import 'dart:async';

import 'package:asami_admin_app/Pages/CountriesPage/contries_page.dart';
import 'package:asami_admin_app/Pages/MembersPage/members_page.dart';
import 'package:asami_admin_app/Pages/OrderFulfillPage/order_fulfill_page.dart';
import 'package:asami_admin_app/Pages/PostFeedPage/post_feed_page.dart';
import 'package:asami_admin_app/Pages/PostNotificationPage/post_notification_page.dart';
import 'package:asami_admin_app/Pages/PromoCodeListPage/promo_code_list_page.dart';
import 'package:flutter/material.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keicy_progress_dialog/keicy_progress_dialog.dart';
import 'package:keicy_raised_button/keicy_raised_button.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import 'package:keicy_network_image/keicy_network_image.dart';

import 'index.dart';
import 'package:asami_admin_app/Pages/App/index.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with TickerProviderStateMixin {
  DashboardPageStyles _dashboardPageStyles;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _dashboardPageStyles = DashboardPageMobileStyles(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DashboardPageProvider()),
      ],
      child: Builder(builder: (context) {
        return _containerMain(context);
      }),
    );
  }

  Widget _containerMain(BuildContext context) {
    DashboardPageProvider.of(context).getUserCountStream();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(_dashboardPageStyles.deviceWidth, _dashboardPageStyles.asamiAppbarHeight),
        child: Container(
          padding: EdgeInsets.all(_dashboardPageStyles.asamiAppbarBottomPadding),
          alignment: Alignment.bottomCenter,
          color: AppColors.appbarColor,
          child: Text(
            DashboardPageString.appbarTitle,
            style: TextStyle(
              fontSize: _dashboardPageStyles.appbarTitleFontSize,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Container(
        width: _dashboardPageStyles.deviceWidth,
        height: _dashboardPageStyles.safeAreaHeight,
        padding: EdgeInsets.symmetric(
          horizontal: _dashboardPageStyles.primaryHorizontalPadding,
          vertical: _dashboardPageStyles.primaryVerticalPadding,
        ),
        decoration: BoxDecoration(color: DashboardPageColors.backColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                /// members
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => MembersPage()));
                  },
                  child: Container(
                    width: _dashboardPageStyles.categoryWidth,
                    height: _dashboardPageStyles.categoryHeight,
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: _dashboardPageStyles.categoryHorizontalPadding,
                      vertical: _dashboardPageStyles.categoryVerticalPadding,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        FaIcon(FontAwesomeIcons.userFriends, size: _dashboardPageStyles.categoryIconSize),
                        Container(
                          height: _dashboardPageStyles.textFontSize * 2,
                          child: Text(
                            DashboardPageString.membersLabel,
                            style: TextStyle(
                              fontSize: _dashboardPageStyles.textFontSize,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// order Fuffilment
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => OrderFulfillPage()));
                  },
                  child: Container(
                    width: _dashboardPageStyles.categoryWidth,
                    height: _dashboardPageStyles.categoryHeight,
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: _dashboardPageStyles.categoryHorizontalPadding,
                      vertical: _dashboardPageStyles.categoryVerticalPadding,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        FaIcon(FontAwesomeIcons.coffee, size: _dashboardPageStyles.categoryIconSize),
                        Container(
                          height: _dashboardPageStyles.textFontSize * 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                DashboardPageString.orderLabel,
                                style: TextStyle(
                                  fontSize: _dashboardPageStyles.textFontSize,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: _dashboardPageStyles.widthDp * 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                /// POST NOTIFICATION
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => PostNotificationPage()));
                  },
                  child: Container(
                    width: _dashboardPageStyles.categoryWidth,
                    height: _dashboardPageStyles.categoryHeight,
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: _dashboardPageStyles.categoryHorizontalPadding,
                      vertical: _dashboardPageStyles.categoryVerticalPadding,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        FaIcon(FontAwesomeIcons.solidBell, size: _dashboardPageStyles.categoryIconSize),
                        Container(
                          height: _dashboardPageStyles.textFontSize * 2,
                          child: Text(
                            DashboardPageString.postNotificationLabel,
                            style: TextStyle(
                              fontSize: _dashboardPageStyles.textFontSize,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// post feed
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => PostFeedPage()));
                  },
                  child: Container(
                    width: _dashboardPageStyles.categoryWidth,
                    height: _dashboardPageStyles.categoryHeight,
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: _dashboardPageStyles.categoryHorizontalPadding,
                      vertical: _dashboardPageStyles.categoryVerticalPadding,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        FaIcon(FontAwesomeIcons.fileAlt, size: _dashboardPageStyles.categoryIconSize),
                        Container(
                          height: _dashboardPageStyles.textFontSize * 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                DashboardPageString.postFeedLabel,
                                style: TextStyle(
                                  fontSize: _dashboardPageStyles.textFontSize,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: _dashboardPageStyles.widthDp * 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                /// promo
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => PromoCodeListPage()));
                  },
                  child: Container(
                    width: _dashboardPageStyles.categoryWidth,
                    height: _dashboardPageStyles.categoryHeight,
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: _dashboardPageStyles.categoryHorizontalPadding,
                      vertical: _dashboardPageStyles.categoryVerticalPadding,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        FaIcon(FontAwesomeIcons.vrCardboard, size: _dashboardPageStyles.categoryIconSize),
                        Container(
                          height: _dashboardPageStyles.textFontSize * 2,
                          child: Text(
                            DashboardPageString.promoCodesLabel,
                            style: TextStyle(
                              fontSize: _dashboardPageStyles.textFontSize,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// country
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => CountriesPage()));
                  },
                  child: Container(
                    width: _dashboardPageStyles.categoryWidth,
                    height: _dashboardPageStyles.categoryHeight,
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: _dashboardPageStyles.categoryHorizontalPadding,
                      vertical: _dashboardPageStyles.categoryVerticalPadding,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        FaIcon(FontAwesomeIcons.globeAfrica, size: _dashboardPageStyles.categoryIconSize),
                        Container(
                          height: _dashboardPageStyles.textFontSize * 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                DashboardPageString.countriesLabel,
                                style: TextStyle(
                                  fontSize: _dashboardPageStyles.textFontSize,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),

            SizedBox(height: _dashboardPageStyles.widthDp * 38),

            /// promo
            StreamBuilder<int>(
                stream: DashboardPageProvider.of(context).userCountStream,
                builder: (context, snapshot) {
                  int _count;
                  if (!snapshot.hasData) _count = 0;
                  if (snapshot.data == null)
                    _count = 0;
                  else
                    _count = snapshot.data;
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      height: _dashboardPageStyles.categoryHeight,
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: _dashboardPageStyles.categoryHorizontalPadding,
                        vertical: _dashboardPageStyles.categoryVerticalPadding,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "$_count",
                            style: TextStyle(
                              fontSize: _dashboardPageStyles.amountTextFontSize,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          // SizedBox(height: _dashboardPageStyles.widthDp * 10),
                          Text(
                            DashboardPageString.membersCount,
                            style: TextStyle(
                              fontSize: _dashboardPageStyles.textFontSize,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
