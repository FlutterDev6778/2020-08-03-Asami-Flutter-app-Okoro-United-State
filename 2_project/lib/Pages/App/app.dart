import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './index.dart';

import 'package:asami_app/Pages/SplashPage/splash_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppDataProvider()),
      ],
      child: MaterialApp(
        theme: buildThemeData(context),
        home: SplashPage(),
        routes: {
          AppRoutes.splashPage: (context) => SplashPage(),
        },
      ),
    );
  }
}
