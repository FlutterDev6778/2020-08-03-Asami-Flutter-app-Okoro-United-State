import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

class AppDataProviderListener {
  static listener(BuildContext context, AppDataProvider accountInitPageProvider) async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      /// add listeners
    });
  }
}
