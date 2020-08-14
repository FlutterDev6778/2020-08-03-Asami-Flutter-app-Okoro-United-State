import 'package:asami_backend/DataProviders/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardPageProvider extends ChangeNotifier {
  static DashboardPageProvider of(BuildContext context, {bool listen = false}) => Provider.of<DashboardPageProvider>(context, listen: listen);

  Stream<int> _userCountStream;
  Stream<int> get userCountStream => _userCountStream;
  void getUserCountStream() {
    _userCountStream = UserDataProvider.getUserCountStream();
  }
}
