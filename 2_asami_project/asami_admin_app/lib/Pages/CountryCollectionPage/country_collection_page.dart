import 'dart:async';

import 'package:asami_admin_app/Pages/AttracctionPage/attraction_page.dart';
import 'package:asami_admin_app/Pages/FactPage/fact_page.dart';
import 'package:flutter/material.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keicy_cupertino_indicator/keicy_cupertino_indicator.dart';
import 'package:keicy_progress_dialog/keicy_progress_dialog.dart';
import 'package:provider/provider.dart';

import 'package:keicy_network_image/keicy_network_image.dart';

import 'index.dart';

import 'package:asami_backend/asami_backend.dart';

import 'package:asami_admin_app/Pages/App/index.dart';
import 'package:asami_admin_app/Pages/HerbPage/herb_page.dart';

class CountryCollectionPage extends StatefulWidget {
  CountryCollectionPage({@required this.countryName});

  String countryName;
  @override
  _CountryCollectionPageState createState() => _CountryCollectionPageState();
}

class _CountryCollectionPageState extends State<CountryCollectionPage> with TickerProviderStateMixin {
  CountryCollectionPageStyles _countryCollectionPageStyles;
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: 3, initialIndex: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    _countryCollectionPageStyles = CountryCollectionPageMobileStyles(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CountryCollectionPageProvider()),
        ChangeNotifierProvider(create: (_) => FactPagePopupProvider()),
      ],
      child: Builder(builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            if (FactPagePopupProvider.of(context).isPopupWindow) {
              FactPagePopupProvider.of(context).setFactModel(null);
              FactPagePopupProvider.of(context).setIsNew(false);
              FactPagePopupProvider.of(context).setIsPopupWindow(false);
              return false;
            } else {
              return true;
            }
          },
          child: _containerMain(context),
        );
      }),
    );
  }

  Widget _containerMain(BuildContext context) {
    CountryCollectionPageProvider.of(context).getHerbListStream(countryName: widget.countryName);
    CountryCollectionPageProvider.of(context).getAttractionListStream(countryName: widget.countryName);
    CountryCollectionPageProvider.of(context).getFactListStream(countryName: widget.countryName);

    return Consumer<FactPagePopupProvider>(builder: (context, factPagePopupProvider, _) {
      return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: true,
        body: Stack(
          children: [
            DefaultTabController(
              length: 3,
              child: Container(
                width: _countryCollectionPageStyles.deviceWidth,
                height: _countryCollectionPageStyles.deviceHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _containerHeader(context),
                    Expanded(child: _containerTabView(context, factPagePopupProvider)),
                  ],
                ),
              ),
            ),
            (factPagePopupProvider.isPopupWindow)
                ? FactPage(
                    factPagePopupProvider: factPagePopupProvider,
                    factModel: factPagePopupProvider.factModel,
                    isNew: factPagePopupProvider.isNew,
                  )
                : SizedBox(),
          ],
        ),
      );
    });
  }

  Widget _containerHeader(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: _countryCollectionPageStyles.deviceWidth,
          height: _countryCollectionPageStyles.asamiAppbarHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(image: AssetImage(AppAssets.country), fit: BoxFit.cover),
          ),
          child: Stack(
            children: <Widget>[
              Container(
                width: _countryCollectionPageStyles.deviceWidth,
                height: _countryCollectionPageStyles.asamiAppbarHeight,
                color: Colors.black26,
              ),
              Container(
                width: _countryCollectionPageStyles.deviceWidth,
                height: _countryCollectionPageStyles.asamiAppbarHeight,
                padding: EdgeInsets.only(
                  left: _countryCollectionPageStyles.asamiAppbarHorizontalPadding,
                  right: _countryCollectionPageStyles.asamiAppbarHorizontalPadding,
                  top: _countryCollectionPageStyles.asamiAppbarTopPadding,
                  bottom: _countryCollectionPageStyles.asamiAppbarBottomPadding,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          child: Icon(Icons.arrow_back_ios, size: _countryCollectionPageStyles.iconSize, color: Colors.white),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        GestureDetector(
                          child: FaIcon(FontAwesomeIcons.plane, size: _countryCollectionPageStyles.iconSize, color: Colors.transparent),
                          onTap: () {},
                        ),
                      ],
                    ),
                    Text(
                      widget.countryName,
                      style: TextStyle(fontSize: _countryCollectionPageStyles.appbarTitleFontSize, color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: kBottomNavigationBarHeight,
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.primaryColor.withAlpha(150)))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: TabBar(
                  controller: _tabController,
                  labelStyle: TextStyle(fontSize: _countryCollectionPageStyles.textFontSize, fontWeight: FontWeight.bold),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: AppColors.primaryColor,
                  indicatorWeight: _countryCollectionPageStyles.widthDp * 5,
                  labelPadding: EdgeInsets.symmetric(vertical: _countryCollectionPageStyles.widthDp * 4),
                  tabs: [
                    Text(
                      CountryCollectionPageString.herbsTabLabel,
                      style: TextStyle(fontSize: _countryCollectionPageStyles.textFontSize, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      CountryCollectionPageString.attractionsTabLabel,
                      style: TextStyle(fontSize: _countryCollectionPageStyles.textFontSize, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      CountryCollectionPageString.factsTabLabel,
                      style: TextStyle(fontSize: _countryCollectionPageStyles.textFontSize, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _containerTabView(BuildContext context, FactPagePopupProvider factPagePopupProvider) {
    return Consumer<CountryCollectionPageProvider>(builder: (context, countryCollectionPageProvider, _) {
      if (countryCollectionPageProvider.progressState != 1 && KeicyProgressDialog.of(context).isShowing()) {
        KeicyProgressDialog.of(context).hide();
      }

      return TabBarView(
        controller: _tabController,
        children: [
          _containerHerbs(context, countryCollectionPageProvider),
          _containerAttractions(context, countryCollectionPageProvider),
          _containerFacts(context, countryCollectionPageProvider, factPagePopupProvider),
        ],
      );
    });
  }

  Widget _containerHerbs(BuildContext context, CountryCollectionPageProvider countryCollectionPageProvider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: _countryCollectionPageStyles.deviceWidth,
          height: _countryCollectionPageStyles.addItemHeight,
          padding: EdgeInsets.symmetric(horizontal: _countryCollectionPageStyles.itemHorizontalMargin),
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => HerbPage(
                    isNew: true,
                    herbModel: HerbModel(countryName: widget.countryName),
                  ),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(Icons.add_circle_outline, size: _countryCollectionPageStyles.textFontSize, color: AppColors.primaryColor),
                SizedBox(width: _countryCollectionPageStyles.widthDp * 5),
                Text(
                  CountryCollectionPageString.addHerbLabel,
                  style: TextStyle(fontSize: _countryCollectionPageStyles.textFontSize, color: AppColors.primaryColor),
                ),
              ],
            ),
          ),
        ),
        StreamBuilder<List<Map<String, dynamic>>>(
          stream: countryCollectionPageProvider.herbListStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Expanded(child: KeicyCupertinoIndicator());
            if (snapshot.data.length == 0)
              return Expanded(
                child: Center(
                  child: Text(
                    "No Herb Data",
                    style: TextStyle(
                      fontSize: _countryCollectionPageStyles.textFontSize,
                    ),
                  ),
                ),
              );
            return Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: snapshot.data.map((data) {
                    HerbModel _herbModel = HerbModel.fromJson(data);

                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => HerbPage(
                                  isNew: false,
                                  herbModel: _herbModel,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 3,
                            borderOnForeground: false,
                            margin: EdgeInsets.symmetric(horizontal: _countryCollectionPageStyles.itemHorizontalMargin),
                            child: Container(
                              width: double.infinity,
                              height: _countryCollectionPageStyles.itemHeight,
                              padding: EdgeInsets.symmetric(horizontal: _countryCollectionPageStyles.itemHorizontalPadding),
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        KeicyNetworkImage(
                                          url: _herbModel.imageUrl,
                                          width: _countryCollectionPageStyles.itemImageSize,
                                          height: _countryCollectionPageStyles.itemImageSize,
                                          borderRadius: _countryCollectionPageStyles.itemImageSize / 2,
                                        ),
                                        SizedBox(width: _countryCollectionPageStyles.widthDp * 15),
                                        Expanded(
                                          child: Text(
                                            _herbModel.name,
                                            style: TextStyle(fontSize: _countryCollectionPageStyles.titleFontSize),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        child: Icon(
                                          Icons.delete,
                                          size: _countryCollectionPageStyles.iconSize,
                                          color: Colors.red,
                                        ),
                                        onTap: () async {
                                          await KeicyProgressDialog.of(context).show();
                                          countryCollectionPageProvider.deleteHerb(_herbModel);
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: _countryCollectionPageStyles.widthDp * 20),
                      ],
                    );
                  }).toList(),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  Widget _containerAttractions(BuildContext context, CountryCollectionPageProvider countryCollectionPageProvider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: _countryCollectionPageStyles.deviceWidth,
          height: _countryCollectionPageStyles.addItemHeight,
          padding: EdgeInsets.symmetric(horizontal: _countryCollectionPageStyles.itemHorizontalMargin),
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => AttractionPage(
                    isNew: true,
                    attractionModel: AttractionModel(countryName: widget.countryName),
                  ),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(Icons.add_circle_outline, size: _countryCollectionPageStyles.textFontSize, color: AppColors.primaryColor),
                SizedBox(width: _countryCollectionPageStyles.widthDp * 5),
                Text(
                  CountryCollectionPageString.addAttractionbLabel,
                  style: TextStyle(fontSize: _countryCollectionPageStyles.textFontSize, color: AppColors.primaryColor),
                ),
              ],
            ),
          ),
        ),
        StreamBuilder<List<Map<String, dynamic>>>(
          stream: countryCollectionPageProvider.attractionListStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Expanded(child: KeicyCupertinoIndicator());
            if (snapshot.data.length == 0)
              return Expanded(
                child: Center(
                  child: Text(
                    "No Attraction Data",
                    style: TextStyle(
                      fontSize: _countryCollectionPageStyles.textFontSize,
                    ),
                  ),
                ),
              );
            return Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: snapshot.data.map((data) {
                    AttractionModel _attractionModel = AttractionModel.fromJson(data);

                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => AttractionPage(
                                  isNew: false,
                                  attractionModel: _attractionModel,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 3,
                            borderOnForeground: false,
                            margin: EdgeInsets.symmetric(horizontal: _countryCollectionPageStyles.itemHorizontalMargin),
                            child: Container(
                              width: double.infinity,
                              height: _countryCollectionPageStyles.itemHeight,
                              padding: EdgeInsets.symmetric(horizontal: _countryCollectionPageStyles.itemHorizontalPadding),
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        KeicyNetworkImage(
                                          url: _attractionModel.imageUrl,
                                          width: _countryCollectionPageStyles.itemImageSize,
                                          height: _countryCollectionPageStyles.itemImageSize,
                                          borderRadius: _countryCollectionPageStyles.itemImageSize / 2,
                                        ),
                                        SizedBox(width: _countryCollectionPageStyles.widthDp * 15),
                                        Expanded(
                                          child: Text(
                                            _attractionModel.name,
                                            style: TextStyle(fontSize: _countryCollectionPageStyles.titleFontSize),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        child: Icon(
                                          Icons.delete,
                                          size: _countryCollectionPageStyles.iconSize,
                                          color: Colors.red,
                                        ),
                                        onTap: () async {
                                          await KeicyProgressDialog.of(context).show();
                                          countryCollectionPageProvider.deleteAttraction(_attractionModel);
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: _countryCollectionPageStyles.widthDp * 20),
                      ],
                    );
                  }).toList(),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  Widget _containerFacts(
      BuildContext context, CountryCollectionPageProvider countryCollectionPageProvider, FactPagePopupProvider factPagePopupProvider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: _countryCollectionPageStyles.deviceWidth,
          height: _countryCollectionPageStyles.addItemHeight,
          padding: EdgeInsets.symmetric(horizontal: _countryCollectionPageStyles.itemHorizontalMargin),
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              factPagePopupProvider.setFactModel(FactModel(countryName: widget.countryName));
              factPagePopupProvider.setIsNew(true);
              factPagePopupProvider.setIsPopupWindow(true);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(Icons.add_circle_outline, size: _countryCollectionPageStyles.textFontSize, color: AppColors.primaryColor),
                SizedBox(width: _countryCollectionPageStyles.widthDp * 5),
                Text(
                  CountryCollectionPageString.addFactLabel,
                  style: TextStyle(fontSize: _countryCollectionPageStyles.textFontSize, color: AppColors.primaryColor),
                ),
              ],
            ),
          ),
        ),
        StreamBuilder<List<Map<String, dynamic>>>(
          stream: countryCollectionPageProvider.factListStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Expanded(child: KeicyCupertinoIndicator());
            if (snapshot.data.length == 0)
              return Expanded(
                child: Center(
                  child: Text(
                    "No Fact Data",
                    style: TextStyle(
                      fontSize: _countryCollectionPageStyles.textFontSize,
                    ),
                  ),
                ),
              );
            return Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: snapshot.data.map((data) {
                    FactModel _factModel = FactModel.fromJson(data);

                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            factPagePopupProvider.setFactModel(_factModel);
                            factPagePopupProvider.setIsNew(false);
                            factPagePopupProvider.setIsPopupWindow(true);
                          },
                          child: Card(
                            elevation: 3,
                            borderOnForeground: false,
                            margin: EdgeInsets.symmetric(horizontal: _countryCollectionPageStyles.itemHorizontalMargin),
                            child: Container(
                              width: double.infinity,
                              height: _countryCollectionPageStyles.itemHeight,
                              padding: EdgeInsets.symmetric(horizontal: _countryCollectionPageStyles.itemHorizontalPadding),
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _factModel.description,
                                      style: TextStyle(fontSize: _countryCollectionPageStyles.titleFontSize),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        child: Icon(
                                          Icons.delete,
                                          size: _countryCollectionPageStyles.iconSize,
                                          color: Colors.red,
                                        ),
                                        onTap: () async {
                                          await KeicyProgressDialog.of(context).show();
                                          countryCollectionPageProvider.deleteFact(_factModel);
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: _countryCollectionPageStyles.widthDp * 20),
                      ],
                    );
                  }).toList(),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
