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
import 'package:asami_app/Pages/HerbDetailPage/herb_detail_page.dart';

class CollectionPage extends StatefulWidget {
  @override
  _CollectionPageState createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> with TickerProviderStateMixin {
  CollectionPageStyles _collectionPageStyles;
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _collectionPageStyles = CollectionPageMobileStyles(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CollectionPageProvider()),
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
        width: _collectionPageStyles.deviceWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _containerHeader(context),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: _collectionPageStyles.widthDp * 15),
                    _containerTourist(context),
                    SizedBox(height: _collectionPageStyles.widthDp * 15),
                    _containerHerbs(context),
                    SizedBox(height: _collectionPageStyles.widthDp * 25),
                    _containerFunFacts(context),
                  ],
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
      width: _collectionPageStyles.deviceWidth,
      height: _collectionPageStyles.asamiAppbarHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(image: NetworkImage("https://netstorage-yen.akamaized.net/images/3o3bpd3r3nks4igcs.jpg"), fit: BoxFit.cover),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            width: _collectionPageStyles.deviceWidth,
            height: _collectionPageStyles.asamiAppbarHeight,
            color: Colors.black26,
          ),
          Container(
            width: _collectionPageStyles.deviceWidth,
            height: _collectionPageStyles.asamiAppbarHeight,
            padding: EdgeInsets.only(
              left: _collectionPageStyles.asamiAppbarHorizontalPadding,
              right: _collectionPageStyles.asamiAppbarHorizontalPadding,
              top: _collectionPageStyles.asamiAppbarTopPadding,
              bottom: _collectionPageStyles.asamiAppbarBottomPadding,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      child: Icon(Icons.arrow_back_ios, size: _collectionPageStyles.iconSize, color: Colors.white),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    GestureDetector(
                      child: FaIcon(FontAwesomeIcons.plane, size: _collectionPageStyles.iconSize, color: Colors.white),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => TripPlanningPage()));
                      },
                    ),
                  ],
                ),
                Text(
                  "Nigeria",
                  style: TextStyle(
                    fontSize: _collectionPageStyles.titleFontSize,
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

  Widget _containerTourist(BuildContext context) {
    return Container(
      width: _collectionPageStyles.deviceWidth,
      padding: EdgeInsets.symmetric(horizontal: _collectionPageStyles.primaryHorizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(CollectionPageString.tourist, style: TextStyle(fontSize: _collectionPageStyles.titleFontSize)),
          SizedBox(height: _collectionPageStyles.widthDp * 15),
          Container(
            height: _collectionPageStyles.tourImageSize,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  width: _collectionPageStyles.tourImageSize,
                  height: _collectionPageStyles.tourImageSize,
                  child: Stack(
                    children: <Widget>[
                      KeicyNetworkImage(
                        url: "https://static01.nyt.com/images/2009/01/25/travel/25hours600.jpg?quality=75&auto=webp&disable=upscale",
                        width: _collectionPageStyles.tourImageSize,
                        height: _collectionPageStyles.tourImageSize,
                        borderRadius: _collectionPageStyles.widthDp * 8,
                      ),
                      Container(
                        width: _collectionPageStyles.tourImageSize,
                        height: _collectionPageStyles.tourImageSize,
                        child: Center(
                          child: Text(
                            "Naija Beach",
                            style: TextStyle(fontSize: _collectionPageStyles.textFontSize, color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(width: _collectionPageStyles.widthDp * 20);
              },
              itemCount: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _containerHerbs(BuildContext context) {
    return Container(
      width: _collectionPageStyles.deviceWidth,
      padding: EdgeInsets.symmetric(horizontal: _collectionPageStyles.primaryHorizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(CollectionPageString.herbs, style: TextStyle(fontSize: _collectionPageStyles.titleFontSize)),
          SizedBox(height: _collectionPageStyles.widthDp * 10),
          Container(
            width: _collectionPageStyles.deviceWidth,
            height: _collectionPageStyles.herbsHeight,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => HerbDetailPage()));
                  },
                  child: Card(
                    child: Container(
                      width: _collectionPageStyles.herbsWidth,
                      height: _collectionPageStyles.herbsHeight,
                      margin: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(_collectionPageStyles.widthDp * 6)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: _collectionPageStyles.herbsWidth,
                            height: _collectionPageStyles.herbsHeight / 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(_collectionPageStyles.widthDp * 6)),
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/A_small_cup_of_coffee.JPG/300px-A_small_cup_of_coffee.JPG"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: _collectionPageStyles.widthDp * 15),
                          Text(
                            "title",
                            style: TextStyle(fontSize: _collectionPageStyles.textFontSize),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: _collectionPageStyles.widthDp * 10);
              },
              itemCount: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _containerFunFacts(BuildContext context) {
    List<int> _testList = [];
    for (var i = 0; i < 20; i++) {
      _testList.add(i);
    }
    return Container(
      width: _collectionPageStyles.deviceWidth,
      padding: EdgeInsets.symmetric(horizontal: _collectionPageStyles.primaryHorizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(CollectionPageString.funFacts, style: TextStyle(fontSize: _collectionPageStyles.titleFontSize)),
          SizedBox(height: _collectionPageStyles.widthDp * 10),
          Container(
            width: double.infinity,
            child: Column(
              children: _testList.map((data) {
                return Column(
                  children: <Widget>[
                    Divider(thickness: 1, height: 1, color: Colors.grey[300]),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: _collectionPageStyles.primaryHorizontalPadding,
                        vertical: _collectionPageStyles.primaryHorizontalPadding,
                      ),
                      child: Text(
                        "Nigeria is home the richest black person in the world.",
                        style: TextStyle(fontSize: _collectionPageStyles.textFontSize),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
          // Container(
          //   width: _collectionPageStyles.deviceWidth,
          //   height: _collectionPageStyles.herbsHeight,
          //   child: ListView.separated(
          //     itemBuilder: (context, index) {
          //       return Container(
          //         padding: EdgeInsets.symmetric(
          //           horizontal: _collectionPageStyles.primaryHorizontalPadding,
          //           vertical: _collectionPageStyles.primaryHorizontalPadding,
          //         ),
          //         child: Text(
          //           "Nigeria is home the richest black person in the world.",
          //           style: TextStyle(fontSize: _collectionPageStyles.textFontSize),
          //         ),
          //       );
          //     },
          //     separatorBuilder: (BuildContext context, int index) {
          //       return Divider(thickness: 1, height: 1, color: Colors.grey[300]);
          //     },
          //     itemCount: 20,
          //   ),
          // ),
        ],
      ),
    );
  }
}
