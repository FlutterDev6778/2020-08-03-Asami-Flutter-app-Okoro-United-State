import 'dart:async';

import 'package:flutter/material.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:keicy_network_image/keicy_network_image.dart';

import 'index.dart';
import 'package:asami_app/Pages/App/index.dart';
import 'package:asami_app/Pages/TripPlanningPage/trip_planning_page.dart';
import 'package:asami_backend/Models/index.dart';

class HerbDetailPage extends StatefulWidget {
  @override
  _HerbDetailPageState createState() => _HerbDetailPageState();
}

class _HerbDetailPageState extends State<HerbDetailPage> with TickerProviderStateMixin {
  HerbDetailPageStyles _herbDetailPageStyles;
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _herbDetailPageStyles = HerbDetailPageMobileStyles(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HerbDetailPageProvider()),
      ],
      child: Builder(builder: (context) {
        return _containerMain(context);
      }),
    );
  }

  Widget _containerMain(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: _herbDetailPageStyles.deviceWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _containerHeader(context),
            Expanded(
              child: Container(
                width: _herbDetailPageStyles.deviceWidth,
                padding: EdgeInsets.symmetric(
                  horizontal: _herbDetailPageStyles.primaryHorizontalPadding,
                  vertical: _herbDetailPageStyles.primaryVerticalPadding,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: _herbDetailPageStyles.widthDp * 15),
                      _containerDescription(context),
                      SizedBox(height: _herbDetailPageStyles.widthDp * 30),
                      _containerTeaBlends(context),
                      SizedBox(height: _herbDetailPageStyles.widthDp * 80),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _containerHeader(BuildContext context) {
    return Container(
      width: _herbDetailPageStyles.deviceWidth,
      height: _herbDetailPageStyles.asamiAppbarHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/A_small_cup_of_coffee.JPG/300px-A_small_cup_of_coffee.JPG"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            width: _herbDetailPageStyles.deviceWidth,
            height: _herbDetailPageStyles.asamiAppbarHeight,
            color: Colors.black26,
          ),
          Container(
            width: _herbDetailPageStyles.deviceWidth,
            height: _herbDetailPageStyles.asamiAppbarHeight,
            padding: EdgeInsets.only(
              left: _herbDetailPageStyles.asamiAppbarHorizontalPadding,
              right: _herbDetailPageStyles.asamiAppbarHorizontalPadding,
              top: _herbDetailPageStyles.asamiAppbarTopPadding,
              bottom: _herbDetailPageStyles.asamiAppbarBottomPadding,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      child: Icon(Icons.arrow_back_ios, size: _herbDetailPageStyles.iconSize, color: Colors.white),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    GestureDetector(
                      child: FaIcon(FontAwesomeIcons.plane, size: _herbDetailPageStyles.iconSize, color: Colors.transparent),
                      onTap: () {},
                    ),
                  ],
                ),
                Text(
                  "Kola Nut",
                  style: TextStyle(
                    fontSize: _herbDetailPageStyles.titleFontSize,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _containerDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          HerbDetailPageString.descriptioLabel,
          style: TextStyle(fontSize: _herbDetailPageStyles.titleFontSize, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: _herbDetailPageStyles.widthDp * 15),
        Text(
          "The kola nut is a caffeine-containing nut of evergreen trees of the genus Cola, primarily of the species Cola acuminata and Cola nitida.[2] Cola acuminata, an evergreen tree about 20 metres in height, has long, ovoid leaves pointed at both the ends with a leathery texture. The trees have yellow flowers with purple spots, and star-shaped fruit. Inside the fruit, about a dozen round or square seeds develop in a white seed-shell. The nut’s aroma is sweet and rose-like. The first taste is bitter, but it sweetens upon chewing. The nut can be boiled to extract the caffeine.",
          style: TextStyle(fontSize: _herbDetailPageStyles.textFontSize),
        ),
      ],
    );
  }

  Widget _containerTeaBlends(BuildContext context) {
    List<int> _trableItem = [];

    for (var i = 0; i < 3; i++) {
      _trableItem.add(i);
    }

    return Column(
      children: <Widget>[
        Container(
          width: _herbDetailPageStyles.deviceWidth,
          height: _herbDetailPageStyles.blendHeaderHeight,
          padding: EdgeInsets.symmetric(
            vertical: _herbDetailPageStyles.primaryVerticalPadding,
          ),
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.grey[400]))),
          child: Text(
            HerbDetailPageString.blends,
            style: TextStyle(fontSize: _herbDetailPageStyles.titleFontSize),
          ),
        ),
        Column(
          children: _trableItem.map((data) {
            return Container(
              width: _herbDetailPageStyles.deviceWidth,
              height: _herbDetailPageStyles.blendItemHeight,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.grey[300]))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Lavender Tea",
                    style: TextStyle(fontSize: _herbDetailPageStyles.textFontSize),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: _herbDetailPageStyles.iconSize,
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
