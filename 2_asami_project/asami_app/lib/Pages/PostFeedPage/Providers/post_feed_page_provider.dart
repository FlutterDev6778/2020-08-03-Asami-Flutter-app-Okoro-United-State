import 'dart:io';

import 'package:flutter/material.dart';
import 'package:keicy_storage_for_mobile/keicy_storage_for_mobile.dart';
import 'package:provider/provider.dart';

import 'package:asami_backend/DataProviders/feed_data_provider.dart';
import 'package:asami_backend/Models/index.dart';
import 'package:asami_backend/Models/user_model.dart';

class PostFeedPageProvider extends ChangeNotifier {
  static PostFeedPageProvider of(BuildContext context, {bool listen = false}) => Provider.of<PostFeedPageProvider>(context, listen: listen);

  File _imageFile;
  File get imageFile => _imageFile;
  void setImageFile(File imageFile, {bool isNotifiable = true}) {
    if (_imageFile != imageFile) {
      _imageFile = imageFile;
      if (isNotifiable) notifyListeners();
    }
  }

  int _loadingState = 0;
  int get loadingState => _loadingState;
  void setLoadingState(int loadingState, {bool isNotifiable = true}) {
    if (_loadingState != loadingState) {
      _loadingState = loadingState;
      if (isNotifiable) notifyListeners();
    }
  }

  String _errorString = "";
  String get errorString => _errorString;
  void setErrorString(String errorString, {bool isNotifiable = true}) {
    if (_errorString != errorString) {
      _errorString = errorString;
      if (isNotifiable) notifyListeners();
    }
  }

  void postFeed({@required String description, @required UserModel userModel}) async {
    try {
      String imagePath = await KeicyStorageForMobile.instance.uploadFileObject(
        path: "Feeds/",
        fileName: _imageFile.path.split('/').last,
        file: _imageFile,
      );

      FeedModel feedModel = FeedModel();
      feedModel.description = description;
      feedModel.imageUrl = imagePath;
      feedModel.userID = userModel.id;
      feedModel.ts = DateTime.now().millisecondsSinceEpoch;
      Map<String, dynamic> result = await FeedDataProvider.addFeed(feedModel);
      if (result["state"]) {
        _loadingState = 2;
        _errorString = "";
      } else {
        _loadingState = -1;
        _errorString = "Posting Feed Failed";
      }
    } catch (e) {
      _loadingState = -1;
      _errorString = "Posting Feed Failed";
    }
    notifyListeners();
  }
}
