import 'dart:async';

import 'package:flutter/material.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:keicy_network_image/keicy_network_image.dart';

import 'index.dart';
import 'package:asami_app/Pages/App/index.dart';
import 'package:asami_app/Models/index.dart';
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
      child: _containerMain(context),
    );
  }

  Widget _containerMain(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          child: ListView.separated(
            itemCount: 20,
            itemBuilder: (context, index) {
              FeedModel _feedModel = FeedModel();
              _feedModel.title = "Asami";
              _feedModel.description =
                  "I order the tea I loves it so much I want some more! I order the tea I loves it so much I want some more! I order the tea I loves it so much I want some more! I order the tea I loves it so much I want some more!";
              _feedModel.avatarUrl = "https://blog.humanesociety.org/wp-content/tp-images/6a00d83452e09d69e20162fbc59fe9970d-800wi.jpg";
              _feedModel.imageUrl = "https://www.ajar.id/uploads/images/2A_D1.HBS.CL5.07_1.2.2_Preparing_a_Pot_of_Tea_in_a_Hotel.jpg";
              _feedModel.ts = DateTime.now().millisecondsSinceEpoch;

              return _containerFeedItem(_feedModel);
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(color: FeedListPageColors.dividerColor, height: 1, thickness: 1);
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          child: Icon(
            Icons.note_add,
            size: _feedListPageStyles.floatingButtonSize,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => PostFeedPage()));
          },
        ),
      ),
    );
  }

  Widget _containerFeedItem(FeedModel feedModel) {
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
            url: feedModel.avatarUrl,
            borderRadius: _feedListPageStyles.feedImageHeight / 2,
            errorWidget: Container(
              width: _feedListPageStyles.feedImageWidth,
              height: _feedListPageStyles.feedImageHeight,
              color: Colors.grey,
            ),
          ),
          SizedBox(width: _feedListPageStyles.feedSpacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  feedModel.title,
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
  }
}
