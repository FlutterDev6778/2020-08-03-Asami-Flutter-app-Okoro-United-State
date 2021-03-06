import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './index.dart';

import 'package:asami_app/Pages/SplashPage/splash_page.dart';
import 'package:asami_app/Pages/BottomNavbar/bottom_navbar.dart';
import 'package:asami_app/Pages/FeedListPage/feed_list_page.dart';
import 'package:asami_app/Pages/PremiumPage/premium_page.dart';
import 'package:asami_app/Pages/AccountInitPage/account_init_page.dart';
import 'package:asami_app/Pages/AccountPage/account_page.dart';
import 'package:asami_app/Pages/HomePage/home_page.dart';
import 'package:asami_app/Pages/MapViewPage/map_view_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppDataProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        theme: buildThemeData(context),
        home: SplashPage(),
        routes: {
          AppRoutes.splashPage: (context) => SplashPage(),
          AppRoutes.bottomNavbar: (context) => BottomNavbar(),
          AppRoutes.homePage: (context) => HomePage(),
          AppRoutes.mapViewPage: (context) => MapViewPage(),
          AppRoutes.feedListPage: (context) => FeedListPage(),
          AppRoutes.premiumPage: (context) => PremiumPage(),
          AppRoutes.accountInitPage: (context) => AccountInitPage(),
          AppRoutes.accountPage: (context) => AccountPage(),
        },
      ),
    );
  }
}
