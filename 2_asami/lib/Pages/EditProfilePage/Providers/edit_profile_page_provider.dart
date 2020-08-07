import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfilePageProvider extends ChangeNotifier {
  static EditProfilePageProvider of(BuildContext context, {bool listen = false}) => Provider.of<EditProfilePageProvider>(context, listen: listen);
}
