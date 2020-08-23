import 'dart:io';

import 'package:asami_backend/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:keicy_storage_for_mobile/keicy_storage_for_mobile.dart';
import 'package:provider/provider.dart';

import 'package:keicy_utils/validators.dart';

import 'package:asami_backend/Models/index.dart';
import 'package:asami_backend/DataProviders/index.dart';

import '../index.dart';

class AttractionPageProvider extends ChangeNotifier {
  static AttractionPageProvider of(BuildContext context, {bool listen = false}) => Provider.of<AttractionPageProvider>(context, listen: listen);

  AttractionPageProvider({@required AttractionModel attractionModel}) {
    _attractionModel = attractionModel;
  }

  AttractionModel _attractionModel;
  AttractionModel get attractionModel => _attractionModel;
  void setAttractionModel(AttractionModel attractionModel, {bool isNotifiable = true}) {
    if (_attractionModel.toJson().toString() != attractionModel.toJson().toString()) {
      _attractionModel = attractionModel;
      if (isNotifiable) notifyListeners();
    }
  }

  bool _savePossible = false;
  bool get savePossible => _savePossible;
  void setSavePossible(bool savePossible, {bool isNotifiable = true}) {
    if (_savePossible != savePossible) {
      _savePossible = savePossible;
      if (isNotifiable) notifyListeners();
    }
  }

  File _imageFile;
  File get imageFile => _imageFile;
  void setImageFile(File imageFile, {bool isNotifiable = true}) {
    if (_imageFile != imageFile || isNotifiable) {
      _imageFile = imageFile;
      if (_imageFile != null) _imageErrorString = "";
      notifyListeners();
    }
  }

  int _progressState = 0;
  int get progressState => _progressState;
  void setProgressState(int progressState, {bool isNotifiable = true}) {
    if (_progressState != progressState) {
      _progressState = progressState;
      if (isNotifiable) notifyListeners();
    }
  }

  String _imageErrorString = "";
  String get imageErrorString => _imageErrorString;
  void setImageErrorString(String imageErrorString, {bool isNotifiable = true}) {
    if (_imageErrorString != imageErrorString) {
      _imageErrorString = imageErrorString;
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

  void addAttractionHandler() async {
    String imageUrl =
        await KeicyStorageForMobile.instance.uploadFileObject(path: "/Attractions/", fileName: _imageFile.path.split("/").last, file: _imageFile);
    _attractionModel.imageUrl = imageUrl;
    _attractionModel.ts = DateTime.now().millisecondsSinceEpoch;
    Map<String, dynamic> result = await AttractionDataProvider.addAttraction(_attractionModel);
    if (result["state"]) {
      _errorString = "";
      _progressState = 2;
    } else {
      _errorString = AttractionPageString.saveAttractionError;
      _progressState = 2;
    }
    notifyListeners();
  }

  void updateAttractionHandler({@required String oldImagePath}) async {
    if (_imageFile != null) {
      String imageUrl =
          await KeicyStorageForMobile.instance.uploadFileObject(path: "/Attractions/", fileName: _imageFile.path.split("/").last, file: _imageFile);
      if (imageUrl == null) {
        _errorString = AttractionPageString.saveAttractionError;
        _progressState = -1;
        notifyListeners();
        return;
      } else {
        _attractionModel.imageUrl = imageUrl;
      }

      bool deleteImageResult = await KeicyStorageForMobile.instance.deleteFile(path: oldImagePath);
      if (!deleteImageResult) {
        _errorString = AttractionPageString.saveAttractionError;
        _progressState = -1;
        notifyListeners();
        return;
      }
    }

    _attractionModel.ts = DateTime.now().millisecondsSinceEpoch;

    bool result = await AttractionDataProvider.updateAttraction(attractionModel: _attractionModel);
    if (result) {
      _errorString = "";
      _progressState = 2;
    } else {
      _errorString = AttractionPageString.saveAttractionError;
      _progressState = -1;
    }
    notifyListeners();
  }
}
