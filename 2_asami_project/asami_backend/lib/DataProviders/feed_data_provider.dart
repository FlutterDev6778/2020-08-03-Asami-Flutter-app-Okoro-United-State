import 'package:flutter/material.dart';
import 'package:keicy_firestore_data_provider/keicy_firestore_data_provider.dart';

import '../Models/index.dart';

class FeedDataProvider {
  static String _collectionName = "/Feeds";

  static Future<Map<String, dynamic>> addFeed(FeedModel feedModel) async {
    Map<String, dynamic> result = await KeicyFireStoreDataProvider.instance.addDocument(path: _collectionName, data: feedModel.toJson());
    return result;
  }

  static Stream<List<Map<String, dynamic>>> getFeedListStream({String userID}) {
    List<Map<String, dynamic>> wheres = [];
    if (userID != null)
      wheres = [
        {"key": "userID", "val": userID}
      ];

    return KeicyFireStoreDataProvider.instance.getDocumentsStream(
      path: _collectionName,
      wheres: wheres,
      orderby: [
        {"key": "ts", "desc": true},
      ],
    );
  }

  static Future<bool> deleteFeed({@required String id}) async {
    return await KeicyFireStoreDataProvider.instance.deleteDocument(path: _collectionName, id: id);
  }
}
