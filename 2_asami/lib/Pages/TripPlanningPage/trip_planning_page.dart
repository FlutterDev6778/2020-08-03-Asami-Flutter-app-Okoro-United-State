import 'dart:async';

import 'package:flutter/material.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:keicy_network_image/keicy_network_image.dart';

import 'index.dart';
import 'package:asami_app/Pages/App/index.dart';
import 'package:asami_app/Models/index.dart';

class TripPlanningPage extends StatefulWidget {
  @override
  _TripPlanningPageState createState() => _TripPlanningPageState();
}

class _TripPlanningPageState extends State<TripPlanningPage> with TickerProviderStateMixin {
  TripPlanningPageStyles _tripPlanningPageStyles;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _tripPlanningPageStyles = TripPlanningPageMobileStyles(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TripPlanningPageProvider()),
      ],
      child: _containerMain(context),
    );
  }

  Widget _containerMain(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(_tripPlanningPageStyles.deviceWidth, _tripPlanningPageStyles.asamiAppbarHeight),
          child: Container(
            padding: EdgeInsets.all(_tripPlanningPageStyles.asamiAppbarBottomPadding),
            alignment: Alignment.bottomCenter,
            color: AppColors.appbarColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: _tripPlanningPageStyles.iconSize,
                    color: Colors.white,
                  ),
                ),
                Text(
                  TripPlanningPageString.appbarTitle,
                  style: TextStyle(
                    fontSize: _tripPlanningPageStyles.appbarTitleFontSize,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: _tripPlanningPageStyles.iconSize,
                  color: AppColors.appbarColor,
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: _tripPlanningPageStyles.primaryHorizontalPadding,
              vertical: _tripPlanningPageStyles.primaryVerticalPadding,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _containerTravleAgent(context),
                _containerHotelFinder(context),
                _containerFlightFinder(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _containerTravleAgent(BuildContext context) {
    List<int> _trableItem = [];

    for (var i = 0; i < 3; i++) {
      _trableItem.add(i);
    }

    return Column(
      children: <Widget>[
        Container(
          width: _tripPlanningPageStyles.deviceWidth,
          height: _tripPlanningPageStyles.headerHeight,
          padding: EdgeInsets.symmetric(
            horizontal: _tripPlanningPageStyles.itemHorizontalPadding,
            vertical: _tripPlanningPageStyles.itemVerticalPadding,
          ),
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.grey[400]))),
          child: Text(
            TripPlanningPageString.travelAgents,
            style: TextStyle(fontSize: _tripPlanningPageStyles.titleFontSize),
          ),
        ),
        Column(
          children: _trableItem.map((data) {
            return Container(
              width: _tripPlanningPageStyles.deviceWidth,
              height: _tripPlanningPageStyles.itemHeight,
              padding: EdgeInsets.symmetric(
                horizontal: _tripPlanningPageStyles.itemHorizontalPadding,
              ),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.grey[300]))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Lavender Tea",
                    style: TextStyle(fontSize: _tripPlanningPageStyles.textFontSize),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: _tripPlanningPageStyles.iconSize,
                  )
                ],
              ),
            );
          }).toList(),
        )
      ],
    );
  }

  Widget _containerHotelFinder(BuildContext context) {
    List<int> _trableItem = [];

    for (var i = 0; i < 3; i++) {
      _trableItem.add(i);
    }

    return Column(
      children: <Widget>[
        Container(
          width: _tripPlanningPageStyles.deviceWidth,
          height: _tripPlanningPageStyles.headerHeight,
          padding: EdgeInsets.symmetric(
            horizontal: _tripPlanningPageStyles.itemHorizontalPadding,
            vertical: _tripPlanningPageStyles.itemVerticalPadding,
          ),
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.grey[400]))),
          child: Text(
            TripPlanningPageString.hotelFinder,
            style: TextStyle(fontSize: _tripPlanningPageStyles.titleFontSize),
          ),
        ),
        Column(
          children: _trableItem.map((data) {
            return Container(
              width: _tripPlanningPageStyles.deviceWidth,
              height: _tripPlanningPageStyles.itemHeight,
              padding: EdgeInsets.symmetric(
                horizontal: _tripPlanningPageStyles.itemHorizontalPadding,
              ),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.grey[300]))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Lavender Tea",
                    style: TextStyle(fontSize: _tripPlanningPageStyles.textFontSize),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: _tripPlanningPageStyles.iconSize,
                  )
                ],
              ),
            );
          }).toList(),
        )
      ],
    );
  }

  Widget _containerFlightFinder(BuildContext context) {
    List<int> _trableItem = [];

    for (var i = 0; i < 3; i++) {
      _trableItem.add(i);
    }

    return Column(
      children: <Widget>[
        Container(
          width: _tripPlanningPageStyles.deviceWidth,
          height: _tripPlanningPageStyles.headerHeight,
          padding: EdgeInsets.symmetric(
            horizontal: _tripPlanningPageStyles.itemHorizontalPadding,
            vertical: _tripPlanningPageStyles.itemVerticalPadding,
          ),
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.grey[400]))),
          child: Text(
            TripPlanningPageString.flightFinder,
            style: TextStyle(fontSize: _tripPlanningPageStyles.titleFontSize),
          ),
        ),
        Column(
          children: _trableItem.map((data) {
            return Container(
              width: _tripPlanningPageStyles.deviceWidth,
              height: _tripPlanningPageStyles.itemHeight,
              padding: EdgeInsets.symmetric(
                horizontal: _tripPlanningPageStyles.itemHorizontalPadding,
              ),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.grey[300]))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Lavender Tea",
                    style: TextStyle(fontSize: _tripPlanningPageStyles.textFontSize),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: _tripPlanningPageStyles.iconSize,
                  )
                ],
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
