import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:asami_app/Pages/App/index.dart';
import 'package:asami_app/Models/index.dart';
import 'package:asami_app/Helpers/index.dart';

class AuthProvider extends ChangeNotifier {
  static AuthProvider of(BuildContext context, {bool listen = false}) => Provider.of<AuthProvider>(context, listen: listen);

  String _userModelStoreKey = "USER_MODEL";
  String _rememberMeStoreKey = "REMEMBER_ME";

  bool _rememberMe = false;
  bool get rememberMe => _rememberMe;
  void setRememberMe(bool rememberMe, {bool isNotifiable = false}) {
    if (_rememberMe != rememberMe) {
      _rememberMe = rememberMe;
      if (isNotifiable) notifyListeners();
      storeDataToLocal(key: _rememberMeStoreKey, value: _rememberMe, type: StorableDataType.BOOL);
    }
  }

  UserModel _userModel = UserModel();
  UserModel get userModel => _userModel;
  void setUserModel(UserModel userModel, {bool isNotifiable = false}) {
    if (_userModel != userModel) {
      _userModel = userModel;
      if (isNotifiable) notifyListeners();
      if (_rememberMe) {
        storeDataToLocal(key: _userModelStoreKey, value: json.encode(_userModel.toJson()), type: StorableDataType.String);
      }
    }
  }

  AuthState _authState = AuthState.IsNotLogin;
  AuthState get authState => _authState;
  void setAuthState(AuthState authState) {
    if (_authState != authState) {
      _authState = authState;
      notifyListeners();
    }
  }

  Future<void> init() async {
    print("-----------init-----------------");
    try {
      _rememberMe = await getDataInLocal(key: _rememberMeStoreKey, type: StorableDataType.BOOL);
      if (_rememberMe == null) _rememberMe = false;

      if (_rememberMe) {
        _userModel = UserModel.fromJson(json.decode(await getDataInLocal(key: _userModelStoreKey, type: StorableDataType.String)));
        _authState = AuthState.IsLogin;
      }
    } catch (e) {
      _rememberMe = false;
      _userModel = UserModel();
      _authState = AuthState.IsNotLogin;
    }

    print("_rememberMe: $_rememberMe");
    print("_userModel: ${_userModel.toJson()}");
  }

  void signHandler() async {
    Future.delayed(Duration(seconds: 2), () {
      _authState = AuthState.IsLogin;
      UserModel userModel = UserModel();
      userModel.name = "Test Name";
      userModel.email = "test@test.com";
      userModel.avatarUrl =
          "https://image.freepik.com/free-photo/beautiful-young-blonde-caucasian-woman-with-wavy-hair-looking-her-shoulder_1098-17388.jpg";
      userModel.ts = DateTime.now().millisecondsSinceEpoch;
      setRememberMe(true);
      setUserModel(userModel);
      notifyListeners();
    });
  }
}
