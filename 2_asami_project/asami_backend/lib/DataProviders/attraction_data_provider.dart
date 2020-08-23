import 'package:flutter/material.dart';
import 'package:keicy_firestore_data_provider/keicy_firestore_data_provider.dart';

import '../Models/index.dart';

class AttractionDataProvider {
  static String _collectionName = "/Attractions";

  static Future<Map<String, dynamic>> addAttraction(AttractionModel atttractionModel) async {
    Map<String, dynamic> result = await KeicyFireStoreDataProvider.instance.addDocument(path: _collectionName, data: atttractionModel.toJson());
    return result;
  }

  static Stream<List<Map<String, dynamic>>> getAttractionListStream({String countryName}) {
    List<Map<String, dynamic>> wheres = [];
    if (countryName != null)
      wheres = [
        {"key": "countryName", "val": countryName}
      ];

    return KeicyFireStoreDataProvider.instance.getDocumentsStream(
      path: _collectionName,
      wheres: wheres,
      orderby: [
        {"key": "ts", "desc": true},
      ],
    );
  }

  static Future<bool> deleteAttraction({@required String id}) async {
    return await KeicyFireStoreDataProvider.instance.deleteDocument(path: _collectionName, id: id);
  }

  static Future<bool> updateAttraction({@required AttractionModel attractionModel}) async {
    return await KeicyFireStoreDataProvider.instance.updateDocument(
      path: _collectionName,
      id: attractionModel.id,
      data: attractionModel.toJson(),
    );
  }
}
