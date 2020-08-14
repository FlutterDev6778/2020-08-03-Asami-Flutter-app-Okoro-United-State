import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PromoCodesPageProvider extends ChangeNotifier {
  static PromoCodesPageProvider of(BuildContext context, {bool listen = false}) => Provider.of<PromoCodesPageProvider>(context, listen: listen);
}
