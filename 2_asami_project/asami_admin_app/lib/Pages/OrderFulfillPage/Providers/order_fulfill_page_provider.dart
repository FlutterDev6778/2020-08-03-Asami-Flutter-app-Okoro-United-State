import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderFulfillPageProvider extends ChangeNotifier {
  static OrderFulfillPageProvider of(BuildContext context, {bool listen = false}) => Provider.of<OrderFulfillPageProvider>(context, listen: listen);
}
