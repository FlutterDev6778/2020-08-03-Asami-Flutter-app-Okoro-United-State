import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:keicy_firebase_authentication/keicy_firebase_authentication.dart';

import 'package:asami_backend/Models/index.dart';
import 'package:asami_backend/Helpers/index.dart';
import 'package:asami_backend/DataProviders/index.dart';

enum AuthState {
  IsLogin,
  IsNotLogin,
}

class AuthProvider extends ChangeNotifier {
  static AuthProvider of(BuildContext context, {bool listen = false}) => Provider.of<AuthProvider>(context, listen: listen);

  String _userModelStoreKey = "USER_MODEL";
  String _rememberMeStoreKey = "REMEMBER_ME";

  AuthState _authState = AuthState.IsNotLogin;
  AuthState get authState => _authState;
  void setAuthState(AuthState authState, {bool isNotifiable = true}) {
    if (_authState != authState) {
      _authState = authState;
      if (isNotifiable) notifyListeners();
    }
  }

  bool _rememberMe = false;
  bool get rememberMe => _rememberMe;
  Future<void> setRememberMe(bool rememberMe, {bool isNotifiable = true}) async {
    if (_rememberMe != rememberMe) {
      _rememberMe = rememberMe;
      if (isNotifiable) notifyListeners();
      await LocalStorage.storeDataToLocal(key: _rememberMeStoreKey, value: _rememberMe, type: StorableDataType.BOOL);
    }
  }

  UserModel _userModel = UserModel();
  UserModel get userModel => _userModel;
  Future<void> setUserModel(UserModel userModel, {bool isNotifiable = true}) async {
    if (_userModel != userModel) {
      _userModel = userModel;
      if (isNotifiable) notifyListeners();
      if (_rememberMe) {
        await LocalStorage.storeDataToLocal(key: _userModelStoreKey, value: json.encode(_userModel.toJson()), type: StorableDataType.String);
      }
    }
  }

  Future<void> init() async {
    print("-----------init-----------------");
    try {
      _rememberMe = await LocalStorage.getDataInLocal(key: _rememberMeStoreKey, type: StorableDataType.BOOL);
      if (_rememberMe == null) _rememberMe = false;

      if (_rememberMe) {
        _userModel = UserModel.fromJson(json.decode(await LocalStorage.getDataInLocal(key: _userModelStoreKey, type: StorableDataType.String)));
        _authState = AuthState.IsLogin;
      }
    } catch (e) {
      _rememberMe = false;
      _userModel = UserModel();
      _authState = AuthState.IsNotLogin;
    }
  }

  /// auth errorString
  String _errorString = "";
  String get errorString => _errorString;
  void setErrorString(String errorString, {bool isNotifiable = true}) {
    if (_errorString != errorString) {
      _errorString = errorString;
      if (isNotifiable) notifyListeners();
    }
  }

  int _processingState = 0;
  int get processingState => _processingState;
  void setProcessingState(int processingState, {bool isNotifiable = true}) {
    if (_processingState != processingState) {
      _processingState = processingState;
      if (isNotifiable) notifyListeners();
    }
  }

  Future<void> signupWithEmailOnFirebase({@required UserModel userModel, @required String password, bool remeberMe = true}) async {
    /// firebase authentication with email and password
    Map<String, dynamic> authResult = await KeicyAuthentication.instance.signUp(email: userModel.email, password: password);
    if (!authResult["state"]) {
      _processingState = -1;
      _errorString = authResult["errorString"];
      return;
    }
    userModel.uid = authResult["user"].uid;

    /// register userModel on firebase's user collection
    Map<String, dynamic> userResult = await UserDataProvider.addUser(userModel);
    if (!userResult["state"]) {
      _processingState = -1;
      _errorString = userResult["errorString"];
      return;
    }

    _processingState = 2;
    _errorString = "";
    userResult["data"][0]['ts'] = DateTime.now().millisecondsSinceEpoch;
    await setRememberMe(remeberMe, isNotifiable: false);
    await setUserModel(UserModel.fromJson(userResult["data"]), isNotifiable: false);
    // _authState = AuthState.IsLogin;
    notifyListeners();
  }

  Future<void> loginWithEmailOnFirebase({@required String email, @required String password, bool remeberMe = true}) async {
    /// firebase authentication with email and password
    Map<String, dynamic> authResult = await KeicyAuthentication.instance.signIn(email: email, password: password);
    if (!authResult["state"]) {
      _errorString = authResult["errorString"];
      _processingState = -1;
      notifyListeners();
      return;
    }

    /// check userModel on firebase's user collection
    Map<String, dynamic> userResult = await UserDataProvider.getUserByUID(authResult["user"].uid);
    if (!userResult["state"]) {
      _errorString = userResult["errorString"];
      _processingState = -1;
      notifyListeners();
      return;
    } else if (userResult["state"] && userResult["data"].length == 0) {
      _errorString = "No registered User";
      _processingState = -1;
      notifyListeners();
      return;
    }
    _processingState = 2;
    _errorString = "";
    await setRememberMe(remeberMe, isNotifiable: false);
    await setUserModel(UserModel.fromJson(userResult["data"][0]), isNotifiable: false);
    // _authState = AuthState.IsLogin;
    notifyListeners();
  }
}
