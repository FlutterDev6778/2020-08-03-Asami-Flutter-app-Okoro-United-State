import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import 'index.dart';
import 'package:asami_app/Pages/HomePage/home_page.dart';
import 'package:asami_app/Pages/FeedListPage/feed_list_page.dart';
import 'package:asami_app/Pages/PremiumPage/premium_page.dart';
import 'package:asami_app/Pages/AccountInitPage/account_init_page.dart';

class BottomNavbar extends StatefulWidget {
  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> with TickerProviderStateMixin {
  BottomNavbarStyles _bottomNavbarStyles;
  PersistentTabController _controller;
  bool _hideNavBar;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
  }

  @override
  Widget build(BuildContext context) {
    _bottomNavbarStyles = BottomNavbarMobileStyles(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavbarProvider()),
      ],
      child: _containerMain(context),
    );
  }

  Widget _containerMain(BuildContext context) {
    return PersistentTabView(
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      hideNavigationBar: _hideNavBar,
      decoration: NavBarDecoration(
        colorBehindNavBar: Colors.white,
        borderRadius: BorderRadius.circular(0.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 4,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      popAllScreensOnTapOfSelectedTab: true,
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6, // Choose the nav bar style with this property
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return BottomNavbarString.navbarItemList.map((items) {
      Widget iconWidget = (items["icon"].runtimeType == IconDataRegular)
          ? FaIcon(items["icon"], size: _bottomNavbarStyles.iconSize * 0.8)
          : Icon(items["icon"], size: _bottomNavbarStyles.iconSize);
      return PersistentBottomNavBarItem(
        icon: Center(child: iconWidget),
        title: items["title"],
        activeColor: items["activeColor"],
        inactiveColor: items["inactiveColor"],
        // onPressed: () {},
      );
    }).toList();
  }

  List<Widget> _buildScreens() {
    return [
      HomePage(),
      Container(
        child: Center(child: Text("one ")),
      ),
      FeedListPage(),
      PremiumPage(),
      AccountInitPage()
    ];
  }
}
