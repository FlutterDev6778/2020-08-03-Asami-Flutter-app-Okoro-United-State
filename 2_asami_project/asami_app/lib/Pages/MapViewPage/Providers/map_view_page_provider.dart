import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MapViewPageProvider extends ChangeNotifier {
  static MapViewPageProvider of(BuildContext context, {bool listen = false}) => Provider.of<MapViewPageProvider>(context, listen: listen);
}
