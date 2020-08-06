import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:asami_app/Pages/App/index.dart';

class AuthProvider extends ChangeNotifier {
  static AuthProvider of(BuildContext context, {bool listen = false}) => Provider.of<AuthProvider>(context, listen: listen);

  AuthState _authState = AuthState.IsLogin;
  AuthState get authState => _authState;
  void setAuthState(AuthState authState) {
    if (_authState != authState) {
      _authState = authState;
      notifyListeners();
    }
  }
}
