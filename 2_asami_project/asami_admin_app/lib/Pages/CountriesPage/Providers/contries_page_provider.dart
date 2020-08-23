import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountriesPageProvider extends ChangeNotifier {
  static CountriesPageProvider of(BuildContext context, {bool listen = false}) => Provider.of<CountriesPageProvider>(context, listen: listen);
}
