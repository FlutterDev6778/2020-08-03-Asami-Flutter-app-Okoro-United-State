import 'package:flutter/material.dart';
import 'package:keicy_firestore_data_provider/keicy_firestore_data_provider.dart';

import '../Models/index.dart';

class HerbDataProvider {
  static String _collectionName = "/Herbs";

  static Future<Map<String, dynamic>> addHerb(HerbModel herbModel) async {
    Map<String, dynamic> result = await KeicyFireStoreDataProvider.instance.addDocument(path: _collectionName, data: herbModel.toJson());
    return result;
  }

  static Stream<List<Map<String, dynamic>>> getHerbListStream({String countryName}) {
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

  static Future<bool> deleteHerb({@required String id}) async {
    return await KeicyFireStoreDataProvider.instance.deleteDocument(path: _collectionName, id: id);
  }

  static Future<bool> updateHerb({@required HerbModel herbModel}) async {
    return await KeicyFireStoreDataProvider.instance.updateDocument(
      path: _collectionName,
      id: herbModel.id,
      data: herbModel.toJson(),
    );
  }
}
