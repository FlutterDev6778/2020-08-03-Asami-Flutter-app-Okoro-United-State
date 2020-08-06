import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountPageProvider extends ChangeNotifier {
  static AccountPageProvider of(BuildContext context, {bool listen = false}) => Provider.of<AccountPageProvider>(context, listen: listen);
}
