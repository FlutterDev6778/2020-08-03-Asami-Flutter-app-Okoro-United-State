import 'dart:io';

import 'package:asami_backend/DataProviders/index.dart';
import 'package:asami_backend/asami_backend.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PromoCodeListPageProvider extends ChangeNotifier {
  static PromoCodeListPageProvider of(BuildContext context, {bool listen = false}) => Provider.of<PromoCodeListPageProvider>(context, listen: listen);

  Stream<List<Map<String, dynamic>>> _promoCodeListStream;
  Stream<List<Map<String, dynamic>>> get promoCodeListStream => _promoCodeListStream;
  void getPromoCodeListStream() {
    _promoCodeListStream = PromoCodeDataProvider.getPromoCodeListStream();
  }

  int _progressState = 0;
  int get progressState => _progressState;
  void setProgressState(int progressState, {bool isNotifiable = true}) {
    if (_progressState != progressState) {
      _progressState = progressState;
      if (isNotifiable) notifyListeners();
    }
  }

  void deleteFact(PromoCodeModel promoCodeModel) async {
    bool result = await PromoCodeDataProvider.deletePromoCode(id: promoCodeModel.id);
    if (result) {
      _progressState = 2;
    } else {
      _progressState = -1;
    }
    notifyListeners();
  }
}
