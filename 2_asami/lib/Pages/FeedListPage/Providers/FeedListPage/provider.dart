import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedListPageProvider extends ChangeNotifier {
  static FeedListPageProvider of(BuildContext context, {bool listen = false}) => Provider.of<FeedListPageProvider>(context, listen: listen);
}
