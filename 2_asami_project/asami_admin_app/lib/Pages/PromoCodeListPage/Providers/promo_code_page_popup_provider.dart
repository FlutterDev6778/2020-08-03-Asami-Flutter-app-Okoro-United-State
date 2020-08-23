import 'package:asami_backend/Models/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:asami_backend/DataProviders/index.dart';

class PromoCodePagePopupProvider extends ChangeNotifier {
  static PromoCodePagePopupProvider of(BuildContext context, {bool listen = false}) =>
      Provider.of<PromoCodePagePopupProvider>(context, listen: listen);

  bool _isPopupWindow = false;
  bool get isPopupWindow => _isPopupWindow;
  void setIsPopupWindow(bool isPopupWindow) {
    _isPopupWindow = isPopupWindow;
    notifyListeners();
  }

  PromoCodeModel _promoCodeModel;
  PromoCodeModel get promoCodeModel => _promoCodeModel;
  void setPromoCodeModel(PromoCodeModel promoCodeModel) {
    _promoCodeModel = promoCodeModel;
  }

  bool _isNew = false;
  bool get isNew => _isNew;
  void setIsNew(bool isNew) {
    _isNew = isNew;
  }
}
