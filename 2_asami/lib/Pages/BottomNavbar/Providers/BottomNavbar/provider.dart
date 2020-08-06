import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavbarProvider extends ChangeNotifier {
  static BottomNavbarProvider of(BuildContext context, {bool listen = false}) => Provider.of<BottomNavbarProvider>(context, listen: listen);
}
