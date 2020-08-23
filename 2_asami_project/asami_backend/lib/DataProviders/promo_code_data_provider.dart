import 'package:flutter/material.dart';
import 'package:keicy_firestore_data_provider/keicy_firestore_data_provider.dart';

import '../Models/index.dart';

class PromoCodeDataProvider {
  static String _collectionName = "/PromoCodes";

  static Future<Map<String, dynamic>> addPromoCode(PromoCodeModel promoCodeModel) async {
    Map<String, dynamic> result = await KeicyFireStoreDataProvider.instance.addDocument(path: _collectionName, data: promoCodeModel.toJson());
    return result;
  }

  static Stream<List<Map<String, dynamic>>> getPromoCodeListStream() {
    return KeicyFireStoreDataProvider.instance.getDocumentsStream(
      path: _collectionName,
      orderby: [
        {"key": "ts", "desc": true},
      ],
    );
  }

  static Future<bool> deletePromoCode({@required String id}) async {
    return await KeicyFireStoreDataProvider.instance.deleteDocument(path: _collectionName, id: id);
  }

  static Future<bool> updatePromoCode({@required PromoCodeModel promoCodeModel}) async {
    return await KeicyFireStoreDataProvider.instance.updateDocument(
      path: _collectionName,
      id: promoCodeModel.id,
      data: promoCodeModel.toJson(),
    );
  }
}
