import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageProvider extends ChangeNotifier {
  static HomePageProvider of(BuildContext context, {bool listen = false}) => Provider.of<HomePageProvider>(context, listen: listen);
}
