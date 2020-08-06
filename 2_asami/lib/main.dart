import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'Pages/App/app.dart';

void main() async {
  if (!kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
  }

  runApp(App());
}
