import 'dart:io';

import 'package:asami_backend/DataProviders/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MembersPageProvider extends ChangeNotifier {
  static MembersPageProvider of(BuildContext context, {bool listen = false}) => Provider.of<MembersPageProvider>(context, listen: listen);

  Stream<List<Map<String, dynamic>>> _userListStream;
  Stream<List<Map<String, dynamic>>> get userListStream => _userListStream;

  void getUserListStream() {
    _userListStream = UserDataProvider.getUserListStream();
  }

  void refresh() {
    notifyListeners();
  }
}
