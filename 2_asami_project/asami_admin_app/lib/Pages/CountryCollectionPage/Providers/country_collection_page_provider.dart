import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:keicy_storage_for_mobile/keicy_storage_for_mobile.dart';

import 'package:asami_backend/DataProviders/index.dart';
import 'package:asami_backend/asami_backend.dart';

class CountryCollectionPageProvider extends ChangeNotifier {
  static CountryCollectionPageProvider of(BuildContext context, {bool listen = false}) =>
      Provider.of<CountryCollectionPageProvider>(context, listen: listen);

  Stream<List<Map<String, dynamic>>> _herbListStream;
  Stream<List<Map<String, dynamic>>> get herbListStream => _herbListStream;
  void getHerbListStream({@required String countryName}) {
    _herbListStream = HerbDataProvider.getHerbListStream(countryName: countryName);
  }

  Stream<List<Map<String, dynamic>>> _attractionListStream;
  Stream<List<Map<String, dynamic>>> get attractionListStream => _attractionListStream;
  void getAttractionListStream({@required String countryName}) {
    _attractionListStream = AttractionDataProvider.getAttractionListStream(countryName: countryName);
  }

  Stream<List<Map<String, dynamic>>> _factListStream;
  Stream<List<Map<String, dynamic>>> get factListStream => _factListStream;
  void getFactListStream({@required String countryName}) {
    _factListStream = FactDataProvider.getFactListStream(countryName: countryName);
  }

  int _progressState = 0;
  int get progressState => _progressState;
  void setProgressState(int progressState, {bool isNotifiable = true}) {
    if (_progressState != progressState) {
      _progressState = progressState;
      if (isNotifiable) notifyListeners();
    }
  }

  void deleteHerb(HerbModel herbModel) async {
    bool deleteImageResult = await KeicyStorageForMobile.instance.deleteFile(path: herbModel.imageUrl);
    if (!deleteImageResult) {
      _progressState = -1;
      notifyListeners();
      return;
    }
    bool result = await HerbDataProvider.deleteHerb(id: herbModel.id);
    if (result) {
      _progressState = 2;
    } else {
      _progressState = -1;
    }
    notifyListeners();
  }

  void deleteAttraction(AttractionModel attractionModel) async {
    bool deleteImageResult = await KeicyStorageForMobile.instance.deleteFile(path: attractionModel.imageUrl);
    if (!deleteImageResult) {
      _progressState = -1;
      notifyListeners();
      return;
    }
    bool result = await AttractionDataProvider.deleteAttraction(id: attractionModel.id);
    if (result) {
      _progressState = 2;
    } else {
      _progressState = -1;
    }
    notifyListeners();
  }

  void deleteFact(FactModel factModel) async {
    bool result = await FactDataProvider.deleteFact(id: factModel.id);
    if (result) {
      _progressState = 2;
    } else {
      _progressState = -1;
    }
    notifyListeners();
  }
}
