import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:asami_admin_app/Pages/LoginPage/index.dart';

import './index.dart';
import 'package:asami_admin_app/Pages/App/index.dart';
import 'package:asami_admin_app/Pages/DashboardPage/dashboard_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  SplashPageStyles _splashPageStyles;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _init(BuildContext context) async {
    await AuthProvider.of(context).init();
    if (AuthProvider.of(context).authState == AuthState.IsLogin) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => DashboardPage()));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    _splashPageStyles = SplashPageMobileStyles(context);

    _init(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashPageProvider()),
      ],
      child: Builder(builder: (context) {
        return _containerMain(context);
      }),
    );
  }

  Widget _containerMain(BuildContext context) {
    return Scaffold(
      body: Container(
        width: _splashPageStyles.deviceWidth,
        height: _splashPageStyles.safeAreaHeight,
        child: Stack(
          children: <Widget>[
            Image.asset(
              AppAssets.splash,
              width: _splashPageStyles.deviceWidth,
              height: _splashPageStyles.safeAreaHeight,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: _splashPageStyles.logo1ImageTop,
              child: Container(
                width: _splashPageStyles.deviceWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      AppAssets.logo1,
                      width: _splashPageStyles.logo1ImageWidth,
                      fit: BoxFit.fitWidth,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: _splashPageStyles.progressIndicatorTop,
              child: Container(
                width: _splashPageStyles.deviceWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SpinKitFadingCircle(
                      color: Colors.white,
                      size: _splashPageStyles.progressIndicatorSize,
                      controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1500)),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
