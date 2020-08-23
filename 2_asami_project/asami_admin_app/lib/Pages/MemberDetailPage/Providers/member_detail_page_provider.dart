import 'dart:io';

import 'package:asami_backend/DataProviders/user_data_provider.dart';
import 'package:asami_backend/asami_backend.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MemberDetailPageProvider extends ChangeNotifier {
  static MemberDetailPageProvider of(BuildContext context, {bool listen = false}) => Provider.of<MemberDetailPageProvider>(context, listen: listen);

  Stream<List<Map<String, dynamic>>> _userDataStream;
  Stream<List<Map<String, dynamic>>> get userDataStream => _userDataStream;

  void getUserDataStream({@required String userID}) {
    _userDataStream = FeedDataProvider.getFeedListStream(userID: userID);
  }

  void refresh() {
    notifyListeners();
  }
}
