import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountInitPageProvider extends ChangeNotifier {
  static AccountInitPageProvider of(BuildContext context, {bool listen = false}) => Provider.of<AccountInitPageProvider>(context, listen: listen);
}
