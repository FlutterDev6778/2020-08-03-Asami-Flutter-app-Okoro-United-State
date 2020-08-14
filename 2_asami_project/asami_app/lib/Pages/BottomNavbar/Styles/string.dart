import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:asami_app/Pages/App/Styles/index.dart';

class BottomNavbarString {
  static List<Map<String, dynamic>> navbarItemList = [
    {
      "icon": Icons.home,
      // "title": "Home",
      "activeColor": AppColors.primaryColor,
      "inactiveColor": Colors.grey,
    },
    {
      "icon": Icons.location_on,
      // "title": "Task",
      "activeColor": AppColors.primaryColor,
      "inactiveColor": Colors.grey,
    },
    {
      "icon": Icons.language,
      // "title": "Settings",
      "activeColor": AppColors.primaryColor,
      "inactiveColor": Colors.grey,
    },
    {
      "icon": FontAwesomeIcons.gem,
      // "title": "Settings",
      "activeColor": AppColors.primaryColor,
      "inactiveColor": Colors.grey,
    },
    {
      "icon": Icons.person,
      // "title": "Settings",
      "activeColor": AppColors.primaryColor,
      "inactiveColor": Colors.grey,
    },
  ];
}
