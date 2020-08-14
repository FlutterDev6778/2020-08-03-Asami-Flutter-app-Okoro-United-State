import 'dart:async';

import 'package:flutter/material.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:keicy_cupertino_indicator/keicy_cupertino_indicator.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:keicy_network_image/keicy_network_image.dart';
import 'package:keicy_cupertino_indicator/keicy_cupertino_indicator.dart';

import 'index.dart';
import 'package:asami_app/Pages/App/index.dart';
import 'package:asami_backend/Models/index.dart';
import '../../Pages/PostFeedPage/post_feed_page.dart';

class FeedListPage extends StatefulWidget {
  @override
  _FeedListPageState createState() => _FeedListPageState();
}

class _FeedListPageState extends State<FeedListPage> with TickerProviderStateMixin {
  FeedListPageStyles _feedListPageStyles;
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _feedListPageStyles = FeedListPageMobileStyles(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FeedListPageProvider()),
      ],
      child: Builder(builder: (context) {
        return _containerMain(context);
      }),
    );
  }

  Widget _containerMain(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(_feedListPageStyles.deviceWidth, _feedListPageStyles.asamiAppbarHeight),
        child: Container(
          padding: EdgeInsets.all(_feedListPageStyles.asamiAppbarBottomPadding),
          alignment: Alignment.bottomCenter,
          color: AppColors.appbarColor,
          child: Text(
            FeedListPageString.appbarTitle,
            style: TextStyle(
              fontSize: _feedListPageStyles.appbarTitleFontSize,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: _feedListPageStyles.primaryHorizontalPadding,
          vertical: _feedListPageStyles.primaryVerticalPadding,
        ),
        child: Consumer<FeedListPageProvider>(builder: (context, feedListPageProvider, _) {
          feedListPageProvider.setFeedListStream();
          return StreamBuilder<List<Map<String, dynamic>>>(
              stream: feedListPageProvider.feedListStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Center(child: KeicyCupertinoIndicator());

                if (snapshot.data.length == 0) {
                  return Center(
                    child: Text(
                      FeedListPageString.noFeedItem,
                      style: TextStyle(fontSize: _feedListPageStyles.feedTitleFontSize),
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    FeedModel _feedModel = FeedModel.fromJson(snapshot.data[index]);

                    return _containerFeedItem(_feedModel, feedListPageProvider);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(color: FeedListPageColors.dividerColor, height: 1, thickness: 1);
                  },
                );
              });
        }),
      ),
      floatingActionButton: (AuthProvider.of(context).authState == AuthState.IsNotLogin)
          ? SizedBox()
          : FloatingActionButton(
              backgroundColor: AppColors.primaryColor,
              child: Icon(
                Icons.note_add,
                size: _feedListPageStyles.floatingButtonSize,
                color: Colors.white,
              ),
              onPressed: () {
                pushNewScreen(context, screen: PostFeedPage(), withNavBar: false);
              },
            ),
    );
  }

  Widget _containerFeedItem(FeedModel feedModel, FeedListPageProvider feedListPageProvider) {
    feedListPageProvider.setUserStreamList(feedID: feedModel.id, userID: feedModel.userID);
    return StreamBuilder<Map<String, dynamic>>(
        stream: feedListPageProvider.userStreamList[feedModel.id],
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Container(
              width: _feedListPageStyles.deviceWidth,
              height: _feedListPageStyles.widthDp * 50,
              child: Center(child: KeicyCupertinoIndicator()),
            );

          UserModel _userModel = UserModel.fromJson(snapshot.data);

          return Container(
            width: _feedListPageStyles.deviceWidth,
            padding: EdgeInsets.symmetric(
              horizontal: _feedListPageStyles.feedHorizontalPadding,
              vertical: _feedListPageStyles.feedVerticalPadding,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                KeicyNetworkImage(
                  width: _feedListPageStyles.feedAvatarSize,
                  height: _feedListPageStyles.feedAvatarSize,
                  url: _userModel.avatarUrl,
                  borderRadius: _feedListPageStyles.feedAvatarSize / 2,
                  errorWidget: ClipRRect(
                    borderRadius: BorderRadius.circular(_feedListPageStyles.feedAvatarSize / 2),
                    child: Image.asset(
                      AppAssets.avatarImage,
                      width: _feedListPageStyles.feedAvatarSize,
                      height: _feedListPageStyles.feedAvatarSize,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: _feedListPageStyles.feedSpacing),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _userModel.name,
                        style: TextStyle(fontSize: _feedListPageStyles.feedTitleFontSize, color: AppColors.primaryColor),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            DateTimeFormat.format(DateTime.fromMillisecondsSinceEpoch(feedModel.ts), format: "d M Y h:i a"),
                            style: TextStyle(fontSize: _feedListPageStyles.feedDateTimeFontSize, color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(height: _feedListPageStyles.widthDp * 5),
                      Text(
                        feedModel.description,
                        style: TextStyle(fontSize: _feedListPageStyles.feedDateTimeFontSize, color: Colors.black),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: _feedListPageStyles.widthDp * 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          KeicyNetworkImage(
                            width: _feedListPageStyles.feedImageWidth,
                            height: _feedListPageStyles.feedImageHeight,
                            url: feedModel.imageUrl,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
