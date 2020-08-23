import 'package:flutter/material.dart';
import 'package:keicy_firestore_data_provider/keicy_firestore_data_provider.dart';

import '../Models/index.dart';

class FactDataProvider {
  static String _collectionName = "/Facts";

  static Future<Map<String, dynamic>> addFact(FactModel factModel) async {
    Map<String, dynamic> result = await KeicyFireStoreDataProvider.instance.addDocument(path: _collectionName, data: factModel.toJson());
    return result;
  }

  static Stream<List<Map<String, dynamic>>> getFactListStream({String countryName}) {
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

  static Future<bool> deleteFact({@required String id}) async {
    return await KeicyFireStoreDataProvider.instance.deleteDocument(path: _collectionName, id: id);
  }

  static Future<bool> updateFact({@required FactModel factModel}) async {
    return await KeicyFireStoreDataProvider.instance.updateDocument(
      path: _collectionName,
      id: factModel.id,
      data: factModel.toJson(),
    );
  }
}
