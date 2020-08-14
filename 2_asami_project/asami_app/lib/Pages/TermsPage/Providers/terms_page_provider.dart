import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TermsPageProvider extends ChangeNotifier {
  static TermsPageProvider of(BuildContext context, {bool listen = false}) => Provider.of<TermsPageProvider>(context, listen: listen);
}
