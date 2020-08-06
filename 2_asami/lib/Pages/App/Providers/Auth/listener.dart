import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

class AuthProviderListener {
  static listener(BuildContext context, AuthProvider accountInitPageProvider) async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      /// add listeners
    });
  }
}
