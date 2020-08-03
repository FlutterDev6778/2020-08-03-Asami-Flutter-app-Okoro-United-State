import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPageProvider extends ChangeNotifier {
  static SplashPageProvider of(BuildContext context, {bool listen = false}) => Provider.of<SplashPageProvider>(context, listen: listen);
}
