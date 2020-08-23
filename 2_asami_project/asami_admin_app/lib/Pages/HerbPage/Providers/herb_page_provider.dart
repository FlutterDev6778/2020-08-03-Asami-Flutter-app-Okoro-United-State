import 'dart:io';

import 'package:flutter/material.dart';
import 'package:keicy_storage_for_mobile/keicy_storage_for_mobile.dart';
import 'package:provider/provider.dart';

import 'package:asami_backend/Models/index.dart';
import 'package:asami_backend/DataProviders/index.dart';

import '../index.dart';

class HerbPageProvider extends ChangeNotifier {
  static HerbPageProvider of(BuildContext context, {bool listen = false}) => Provider.of<HerbPageProvider>(context, listen: listen);

  HerbPageProvider({@required HerbModel herbModel}) {
    _herbModel = herbModel;
  }

  HerbModel _herbModel;
  HerbModel get herbModel => _herbModel;
  void setHerbModel(HerbModel herbModel, {bool isNotifiable = true}) {
    if (_herbModel.toJson().toString() != herbModel.toJson().toString()) {
      _herbModel = herbModel;
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

  void addHerbHandler() async {
    String imageUrl =
        await KeicyStorageForMobile.instance.uploadFileObject(path: "/Herbs/", fileName: _imageFile.path.split("/").last, file: _imageFile);
    _herbModel.imageUrl = imageUrl;
    _herbModel.ts = DateTime.now().millisecondsSinceEpoch;
    Map<String, dynamic> result = await HerbDataProvider.addHerb(_herbModel);
    if (result["state"]) {
      _errorString = "";
      _progressState = 2;
    } else {
      _errorString = HerbPageString.saveHerbError;
      _progressState = 2;
    }
    notifyListeners();
  }

  void updateHerbHandler({@required String oldImagePath}) async {
    if (_imageFile != null) {
      String imageUrl =
          await KeicyStorageForMobile.instance.uploadFileObject(path: "/Herbs/", fileName: _imageFile.path.split("/").last, file: _imageFile);
      if (imageUrl == null) {
        _errorString = HerbPageString.saveHerbError;
        _progressState = -1;
        notifyListeners();
        return;
      } else {
        _herbModel.imageUrl = imageUrl;
      }

      bool deleteImageResult = await KeicyStorageForMobile.instance.deleteFile(path: oldImagePath);
      if (!deleteImageResult) {
        _errorString = HerbPageString.saveHerbError;
        _progressState = -1;
        notifyListeners();
        return;
      }
    }

    _herbModel.ts = DateTime.now().millisecondsSinceEpoch;

    bool result = await HerbDataProvider.updateHerb(herbModel: _herbModel);
    if (result) {
      _errorString = "";
      _progressState = 2;
    } else {
      _errorString = HerbPageString.saveHerbError;
      _progressState = -1;
    }
    notifyListeners();
  }
}
