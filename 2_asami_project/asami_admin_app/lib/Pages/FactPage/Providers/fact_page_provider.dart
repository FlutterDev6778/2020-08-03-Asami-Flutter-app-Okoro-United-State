import 'dart:io';

import 'package:flutter/material.dart';
import 'package:keicy_storage_for_mobile/keicy_storage_for_mobile.dart';
import 'package:provider/provider.dart';

import 'package:asami_backend/Models/index.dart';
import 'package:asami_backend/DataProviders/index.dart';

import '../index.dart';

class FactPageProvider extends ChangeNotifier {
  static FactPageProvider of(BuildContext context, {bool listen = false}) => Provider.of<FactPageProvider>(context, listen: listen);

  FactPageProvider({@required FactModel factModel}) {
    _factModel = factModel;
  }

  FactModel _factModel;
  FactModel get factModel => _factModel;
  void setFactModel(FactModel herbModel, {bool isNotifiable = true}) {
    if (_factModel.toJson().toString() != herbModel.toJson().toString()) {
      _factModel = herbModel;
      if (isNotifiable) notifyListeners();
    }
  }

  int _progressState = 0;
  int get progressState => _progressState;
  void setProgressState(int progressState, {bool isNotifiable = true}) {
    if (_progressState != progressState) {
      _progressState = progressState;
      if (isNotifiable) notifyListeners();
    }
  }

  String _errorString = "";
  String get errorString => _errorString;
  void setErrorString(String errorString, {bool isNotifiable = true}) {
    if (_errorString != errorString) {
      _errorString = errorString;
      if (isNotifiable) notifyListeners();
    }
  }

  void addFactHandler() async {
    _factModel.ts = DateTime.now().millisecondsSinceEpoch;
    Map<String, dynamic> result = await FactDataProvider.addFact(_factModel);
    if (result["state"]) {
      _errorString = "";
      _progressState = 2;
    } else {
      _errorString = FactPageString.saveFactError;
      _progressState = 2;
    }
    notifyListeners();
  }

  void updateFactHandler() async {
    _factModel.ts = DateTime.now().millisecondsSinceEpoch;
    bool result = await FactDataProvider.updateFact(factModel: _factModel);
    if (result) {
      _errorString = "";
      _progressState = 2;
    } else {
      _errorString = FactPageString.saveFactError;
      _progressState = -1;
    }
    notifyListeners();
  }
}
