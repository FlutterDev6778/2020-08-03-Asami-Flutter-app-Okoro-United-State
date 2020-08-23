import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostNotificationPageProvider extends ChangeNotifier {
  static PostNotificationPageProvider of(BuildContext context, {bool listen = false}) =>
      Provider.of<PostNotificationPageProvider>(context, listen: listen);
}
