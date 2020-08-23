import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPageProvider extends ChangeNotifier {
  static LoginPageProvider of(BuildContext context, {bool listen = false}) => Provider.of<LoginPageProvider>(context, listen: listen);
}
