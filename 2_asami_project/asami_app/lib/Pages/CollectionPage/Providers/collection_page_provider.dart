import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollectionPageProvider extends ChangeNotifier {
  static CollectionPageProvider of(BuildContext context, {bool listen = false}) => Provider.of<CollectionPageProvider>(context, listen: listen);
}
