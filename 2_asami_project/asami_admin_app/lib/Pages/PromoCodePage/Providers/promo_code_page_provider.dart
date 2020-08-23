import 'dart:io';

import 'package:asami_backend/DataProviders/promo_code_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:keicy_storage_for_mobile/keicy_storage_for_mobile.dart';
import 'package:provider/provider.dart';

import 'package:asami_backend/Models/index.dart';
import 'package:asami_backend/DataProviders/index.dart';

import '../index.dart';

class PromoCodePageProvider extends ChangeNotifier {
  static PromoCodePageProvider of(BuildContext context, {bool listen = false}) => Provider.of<PromoCodePageProvider>(context, listen: listen);

  PromoCodePageProvider({@required PromoCodeModel promoCodeModel}) {
    _promoCodeModel = promoCodeModel;
  }

  PromoCodeModel _promoCodeModel;
  PromoCodeModel get promoCodeModel => _promoCodeModel;
  void setPromoCodeModel(PromoCodeModel herbModel, {bool isNotifiable = true}) {
    if (_promoCodeModel.toJson().toString() != herbModel.toJson().toString()) {
      _promoCodeModel = herbModel;
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

  void addPromoCodeHandler() async {
    _promoCodeModel.ts = DateTime.now().millisecondsSinceEpoch;
    Map<String, dynamic> result = await PromoCodeDataProvider.addPromoCode(_promoCodeModel);
    if (result["state"]) {
      _errorString = "";
      _progressState = 2;
    } else {
      _errorString = PromoCodePageString.savePromoCodeError;
      _progressState = 2;
    }
    notifyListeners();
  }

  void updatePromoCodeHandler() async {
    _promoCodeModel.ts = DateTime.now().millisecondsSinceEpoch;
    bool result = await PromoCodeDataProvider.updatePromoCode(promoCodeModel: _promoCodeModel);
    if (result) {
      _errorString = "";
      _progressState = 2;
    } else {
      _errorString = PromoCodePageString.savePromoCodeError;
      _progressState = -1;
    }
    notifyListeners();
  }
}
