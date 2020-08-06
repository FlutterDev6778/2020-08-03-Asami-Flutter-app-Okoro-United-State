import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PremiumPageProvider extends ChangeNotifier {
  static PremiumPageProvider of(BuildContext context, {bool listen = false}) => Provider.of<PremiumPageProvider>(context, listen: listen);
}
