import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './index.dart';
import 'package:asami_app/Pages/App/Styles/index.dart';

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

  @override
  Widget build(BuildContext context) {
    _splashPageStyles = SplashPageMobileStyles(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashPageProvider()),
      ],
      child: _containerMain(context),
    );
  }

  Widget _containerMain(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: _splashPageStyles.deviceWidth,
          height: _splashPageStyles.deviceHeight,
          child: Stack(
            children: <Widget>[
              Image.asset(
                AppAssets.splash,
                width: _splashPageStyles.deviceWidth,
                height: _splashPageStyles.deviceHeight,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
