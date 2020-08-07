import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TripPlanningPageProvider extends ChangeNotifier {
  static TripPlanningPageProvider of(BuildContext context, {bool listen = false}) => Provider.of<TripPlanningPageProvider>(context, listen: listen);
}
