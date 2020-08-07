import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HerbDetailPageProvider extends ChangeNotifier {
  static HerbDetailPageProvider of(BuildContext context, {bool listen = false}) => Provider.of<HerbDetailPageProvider>(context, listen: listen);
}
