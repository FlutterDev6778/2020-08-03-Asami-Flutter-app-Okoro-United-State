import 'package:asami_backend/Models/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:asami_backend/DataProviders/index.dart';

class FactPagePopupProvider extends ChangeNotifier {
  static FactPagePopupProvider of(BuildContext context, {bool listen = false}) => Provider.of<FactPagePopupProvider>(context, listen: listen);

  bool _isPopupWindow = false;
  bool get isPopupWindow => _isPopupWindow;
  void setIsPopupWindow(bool isPopupWindow) {
    _isPopupWindow = isPopupWindow;
    notifyListeners();
  }

  FactModel _factModel;
  FactModel get factModel => _factModel;
  void setFactModel(FactModel factModel) {
    _factModel = factModel;
  }

  bool _isNew = false;
  bool get isNew => _isNew;
  void setIsNew(bool isNew) {
    _isNew = isNew;
  }
}
