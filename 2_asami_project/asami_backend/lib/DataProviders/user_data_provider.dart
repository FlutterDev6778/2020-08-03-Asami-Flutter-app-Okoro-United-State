import 'package:keicy_firestore_data_provider/keicy_firestore_data_provider.dart';

import '../Models/index.dart';

class UserDataProvider {
  static String _collectionName = "/Users";

  static Future<Map<String, dynamic>> addUser(UserModel userModel) async {
    Map<String, dynamic> result = await KeicyFireStoreDataProvider.instance.addDocument(path: _collectionName, data: userModel.toJson());
    return result;
  }

  static Future<Map<String, dynamic>> getUserByUID(String uid, {bool isAdmin = false}) async {
    List<Map<String, dynamic>> wheres = [];
    wheres = [
      {"key": "uid", "val": uid},
      {"key": "isAdmin", "val": isAdmin}
    ];

    Map<String, dynamic> result = await KeicyFireStoreDataProvider.instance.getDocumentData(
      path: _collectionName,
      wheres: wheres,
      orderby: [
        {"key": "ts", "desc": true},
      ],
    );
    return result;
  }

  static Future<Map<String, dynamic>> getUserByID(String id, {bool isAdmin = false}) async {
    List<Map<String, dynamic>> wheres = [];
    wheres = [
      {"key": "id", "val": id},
      {"key": "isAdmin", "val": isAdmin}
    ];

    Map<String, dynamic> result = await KeicyFireStoreDataProvider.instance.getDocumentData(
      path: _collectionName,
      wheres: wheres,
      orderby: [
        {"key": "ts", "desc": true},
      ],
    );
    return result;
  }

  static Stream<Map<String, dynamic>> getUserDataStream(String id) {
    return KeicyFireStoreDataProvider.instance.getDocumentStreamByID(
      path: _collectionName,
      id: id,
    );
  }

  static Stream<List<Map<String, dynamic>>> getUserListStream({bool isAdmin = false}) {
    List<Map<String, dynamic>> wheres = [];
    wheres.add({"key": "isAdmin", "val": isAdmin});

    return KeicyFireStoreDataProvider.instance.getDocumentsStream(
      path: _collectionName,
      wheres: wheres,
      orderby: [
        {"key": "ts", "desc": true},
        {"key": "isAdmin", "desc": false},
      ],
    );
  }

  static Future<Map<String, dynamic>> getUserList({bool isAdmin = false}) async {
    List<Map<String, dynamic>> wheres = [];
    wheres.add({"key": "isAdmin", "val": isAdmin});

    return await KeicyFireStoreDataProvider.instance.getDocumentData(
      path: _collectionName,
      wheres: wheres,
      orderby: [
        {"key": "ts", "desc": true},
      ],
    );
  }

  static Stream<int> getUserCountStream() {
    return KeicyFireStoreDataProvider.instance.getDocumentsLengthStream(path: _collectionName);
  }
}
