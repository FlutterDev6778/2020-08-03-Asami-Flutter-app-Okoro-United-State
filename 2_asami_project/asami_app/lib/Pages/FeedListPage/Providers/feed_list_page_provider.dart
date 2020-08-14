import 'package:asami_backend/asami_backend.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedListPageProvider extends ChangeNotifier {
  static FeedListPageProvider of(BuildContext context, {bool listen = false}) => Provider.of<FeedListPageProvider>(context, listen: listen);

  Stream<List<Map<String, dynamic>>> _feedListStream;
  Stream<List<Map<String, dynamic>>> get feedListStream => _feedListStream;
  void setFeedListStream() {
    _feedListStream = FeedDataProvider.getFeedListStream();
  }

  Map<String, Stream<Map<String, dynamic>>> _userStreamList = Map<String, Stream<Map<String, dynamic>>>();
  Map<String, Stream<Map<String, dynamic>>> get userStreamList => _userStreamList;

  void setUserStreamList({
    @required String feedID,
    @required String userID,
  }) {
    _userStreamList[feedID] = UserDataProvider.getUserDataStream(userID);
  }
}
