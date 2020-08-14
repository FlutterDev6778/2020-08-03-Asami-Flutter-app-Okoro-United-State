import 'package:asami_backend/DataProviders/index.dart';
import 'package:asami_backend/Models/index.dart';
import 'package:asami_app/Pages/App/index.dart';
import 'package:flutter/material.dart';
import 'package:keicy_firebase_authentication/keicy_firebase_authentication.dart';
import 'package:provider/provider.dart';

class LoginPageProvider extends ChangeNotifier {
  static LoginPageProvider of(BuildContext context, {bool listen = false}) => Provider.of<LoginPageProvider>(context, listen: listen);

  // /// auth errorString
  // String _errorString = "";
  // String get errorString => _errorString;
  // void setErrorString(String errorString, {bool isNotifiable = true}) {
  //   if (_errorString != errorString) {
  //     _errorString = errorString;
  //     if (isNotifiable) notifyListeners();
  //   }
  // }

  // int _processingState = 0;
  // int get processingState => _processingState;
  // void setProcessingState(int processingState, {bool isNotifiable = true}) {
  //   if (_processingState != processingState) {
  //     _processingState = processingState;
  //     if (isNotifiable) notifyListeners();
  //   }
  // }

  // Future<void> signupWithEmailOnFirebase({
  //   @required AuthProvider authProvider,
  //   @required UserModel userModel,
  //   @required String password,
  //   bool remeberMe = true,
  // }) async {
  //   /// firebase authentication with email and password
  //   Map<String, dynamic> authResult = await KeicyAuthentication.instance.signUp(email: userModel.email, password: password);
  //   if (!authResult["state"]) {
  //     _processingState = -1;
  //     _errorString = authResult["errorString"];
  //     return;
  //   }
  //   userModel.uid = authResult["user"].uid;

  //   /// register userModel on firebase's user collection
  //   Map<String, dynamic> userResult = await UserDataProvider.addUser(userModel);
  //   if (!userResult["state"]) {
  //     _processingState = -1;
  //     _errorString = userResult["errorString"];
  //     return;
  //   }

  //   _processingState = 2;
  //   _errorString = "";
  //   await authProvider.setRememberMe(remeberMe, isNotifiable: false);
  //   await authProvider.setUserModel(UserModel.fromJson(userResult["data"]), isNotifiable: false);
  //   // _authState = AuthState.IsLogin;
  //   notifyListeners();
  // }

  // Future<void> loginWithEmailOnFirebase({
  //   @required AuthProvider authProvider,
  //   @required String email,
  //   @required String password,
  //   bool remeberMe = true,
  // }) async {
  //   /// firebase authentication with email and password
  //   Map<String, dynamic> authResult = await KeicyAuthentication.instance.signIn(email: email, password: password);
  //   if (!authResult["state"]) {
  //     _errorString = authResult["errorString"];
  //     _processingState = -1;
  //     notifyListeners();
  //     return;
  //   }

  //   /// check userModel on firebase's user collection
  //   Map<String, dynamic> userResult = await UserDataProvider.getUserByUID(authResult["user"].uid);
  //   if (!userResult["state"]) {
  //     _errorString = userResult["errorString"];
  //     _processingState = -1;
  //     notifyListeners();
  //     return;
  //   } else if (userResult["state"] && userResult["data"].length == 0) {
  //     _errorString = "No registered User";
  //     _processingState = -1;
  //     notifyListeners();
  //     return;
  //   }
  //   _processingState = 2;
  //   _errorString = "";
  //   await authProvider.setRememberMe(remeberMe, isNotifiable: false);
  //   await authProvider.setUserModel(UserModel.fromJson(userResult["data"][0]), isNotifiable: false);
  //   // _authState = AuthState.IsLogin;
  //   notifyListeners();
  // }
}
