import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PremiumMemberPageProvider extends ChangeNotifier {
  static PremiumMemberPageProvider of(BuildContext context, {bool listen = false}) => Provider.of<PremiumMemberPageProvider>(context, listen: listen);
}
