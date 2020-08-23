import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MapViewPageProvider extends ChangeNotifier {
  static MapViewPageProvider of(BuildContext context, {bool listen = false}) => Provider.of<MapViewPageProvider>(context, listen: listen);

  String _countryName;
  String get countryName => _countryName;
  void setCountryName(String countryName) {
    if (_countryName != countryName) {
      _countryName = countryName;
      notifyListeners();
    }
  }

  Stream<List<Map<String, dynamic>>> _herbListStream;
  Stream<List<Map<String, dynamic>>> get herbListStream => _herbListStream;
  void getHerbListStream({@required String countryName}) {
    _herbListStream = HerbDataProvider.getHerbListStream(countryName: countryName);
  }
}
