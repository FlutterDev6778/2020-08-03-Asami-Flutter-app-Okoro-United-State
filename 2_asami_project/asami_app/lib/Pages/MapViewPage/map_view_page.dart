import 'dart:async';

import 'package:asami_backend/Constants/index.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:keicy_network_image/keicy_network_image.dart';

import 'index.dart';
import 'package:asami_app/Pages/App/index.dart';
import 'package:asami_backend/Models/index.dart';
import 'package:asami_app/Pages/CollectionPage/collection_page.dart';

class MapViewPage extends StatefulWidget {
  @override
  _MapViewPageState createState() => _MapViewPageState();
}

class _MapViewPageState extends State<MapViewPage> with TickerProviderStateMixin {
  MapViewPageStyles _mapViewPageStyles;
  GoogleMapController _mapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  PanelController _panelController = PanelController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getMarkers();
  }

  @override
  Widget build(BuildContext context) {
    _mapViewPageStyles = MapViewPageMobileStyles(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MapViewPageProvider()),
      ],
      child: Builder(builder: (context) {
        return _containerMain(context);
      }),
    );
  }

  void _getMarkers() {
    for (var i = 0; i < AppConstants.countryLatLngList.length; i++) {
      MarkerId markerId = MarkerId(AppConstants.countryLatLngList[i]["name"]);
      Marker marker = Marker(
        draggable: false,
        markerId: markerId,
        position: LatLng(
          AppConstants.countryLatLngList[i]["lat"],
          AppConstants.countryLatLngList[i]["long"],
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(title: AppConstants.countryLatLngList[i]["name"]),
        onTap: () {
          _panelController.open();
        },
        consumeTapEvents: true,
      );
      markers[markerId] = marker;
    }
  }

  Widget _containerMain(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(_mapViewPageStyles.deviceWidth, _mapViewPageStyles.asamiAppbarHeight),
        child: Container(
          padding: EdgeInsets.all(_mapViewPageStyles.asamiAppbarBottomPadding),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(AppAssets.mapAppbarImage), fit: BoxFit.cover),
          ),
          child: Image.asset(AppAssets.logo1, width: _mapViewPageStyles.logoImageWidth, fit: BoxFit.fitWidth),
        ),
      ),
      body: SlidingUpPanel(
        body: GestureDetector(
          child: Container(
            width: _mapViewPageStyles.deviceWidth,
            height: _mapViewPageStyles.safeAreaHeight,
            padding: EdgeInsets.symmetric(
              horizontal: _mapViewPageStyles.primaryHorizontalPadding,
              vertical: _mapViewPageStyles.primaryVerticalPadding,
            ),
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
              initialCameraPosition: CameraPosition(target: LatLng(-12.401, 15.629), zoom: 2.01),
              rotateGesturesEnabled: false,
              markers: Set<Marker>.of(markers.values),
              onTap: (LatLng pos) {
                // print("latitude:  ${pos.latitude}");
                // print("longitude:  ${pos.longitude}");
              },
            ),
          ),
        ),
        controller: _panelController,
        minHeight: 0,
        maxHeight: _mapViewPageStyles.slidingPanelMaxHeight,
        borderRadius: BorderRadius.vertical(top: Radius.circular(_mapViewPageStyles.widthDp * 30)),
        boxShadow: null,
        backdropColor: Colors.transparent,
        panel: _contianerSlidingPanel(context),
      ),
    );
  }

  Widget _contianerSlidingPanel(BuildContext context) {
    return Container(
      width: _mapViewPageStyles.deviceWidth,
      height: _mapViewPageStyles.slidingPanelMaxHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(_mapViewPageStyles.widthDp * 30)),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: _mapViewPageStyles.slidinghorizontalPadding,
        vertical: _mapViewPageStyles.slidingVerticalPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: _mapViewPageStyles.tapLineWidth,
            height: _mapViewPageStyles.widthDp * 6,
            color: Colors.black,
          ),
          Text(
            "Nigeria",
            style: TextStyle(
              fontSize: _mapViewPageStyles.itemTitleFontSize,
              color: AppColors.primaryColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                "Explorer",
                style: TextStyle(fontSize: _mapViewPageStyles.explorerFontSize, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Container(
            width: _mapViewPageStyles.deviceWidth,
            height: _mapViewPageStyles.itemHeight,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    pushNewScreen(
                      context,
                      screen: CollectionPage(),
                      withNavBar: false,
                    );
                  },
                  child: Card(
                    child: Container(
                      width: _mapViewPageStyles.itemWidth,
                      height: _mapViewPageStyles.itemHeight,
                      margin: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(_mapViewPageStyles.widthDp * 6)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: _mapViewPageStyles.itemWidth,
                            height: _mapViewPageStyles.itemHeight / 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(_mapViewPageStyles.widthDp * 6)),
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/A_small_cup_of_coffee.JPG/300px-A_small_cup_of_coffee.JPG"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: _mapViewPageStyles.widthDp * 15),
                          Text(
                            "title",
                            style: TextStyle(fontSize: _mapViewPageStyles.itemNameFontSize),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: _mapViewPageStyles.widthDp * 10);
              },
              itemCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
