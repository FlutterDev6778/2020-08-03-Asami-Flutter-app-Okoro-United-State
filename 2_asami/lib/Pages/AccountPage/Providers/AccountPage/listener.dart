import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

class AccountPageProviderListener {
  static listener(BuildContext context, AccountPageProvider accountInitPageProvider) async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      /// add listeners
    });
  }
}
