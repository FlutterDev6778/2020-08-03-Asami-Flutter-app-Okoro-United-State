import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrivacyPageProvider extends ChangeNotifier {
  static PrivacyPageProvider of(BuildContext context, {bool listen = false}) => Provider.of<PrivacyPageProvider>(context, listen: listen);
}
