import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeaClubPageProvider extends ChangeNotifier {
  static TeaClubPageProvider of(BuildContext context, {bool listen = false}) => Provider.of<TeaClubPageProvider>(context, listen: listen);
}
