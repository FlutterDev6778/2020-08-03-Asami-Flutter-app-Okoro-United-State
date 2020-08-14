import 'dart:async';
import 'dart:io';

import 'package:asami_backend/asami_backend.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:keicy_cupertino_indicator/keicy_cupertino_indicator.dart';
import 'package:keicy_network_image/keicy_network_image.dart';
import 'package:keicy_progress_dialog/keicy_progress_dialog.dart';
import 'package:keicy_text_form_field/keicy_text_form_field.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:image_picker/image_picker.dart';

import 'index.dart';
import 'package:asami_app/Pages/App/index.dart';
import 'package:asami_backend/Models/index.dart';

class MemberDetailPage extends StatefulWidget {
  MemberDetailPage({@required this.userModel});

  UserModel userModel;
  @override
  _MemberDetailPageState createState() => _MemberDetailPageState();
}

class _MemberDetailPageState extends State<MemberDetailPage> {
  MemberDetailPageStyles _memberDetailPageStyles;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _memberDetailPageStyles = MemberDetailPageMobileStyles(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MemberDetailPageProvider()),
      ],
      child: Builder(builder: (context) {
        return _containerMain(context);
      }),
    );
  }

  Widget _containerMain(BuildContext context) {
    if (MemberDetailPageProvider.of(context).userDataStream == null)
      MemberDetailPageProvider.of(context).getUserDataStream(
        userID: widget.userModel.id,
      );
    return SafeArea(
      child: Scaffold(
        backgroundColor: MemberDetailPageColors.backColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                child: Icon(Icons.arrow_back_ios, size: _memberDetailPageStyles.iconSize, color: Colors.black),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          elevation: 0,
        ),
        body: Container(
          width: _memberDetailPageStyles.deviceWidth,
          height: _memberDetailPageStyles.safeAreaHeight,
          child: Column(children: <Widget>[
            _containerUserInfo(context),
            Expanded(
              child: _containerFeedList(context),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _containerUserInfo(BuildContext context) {
    return Container(
      width: _memberDetailPageStyles.deviceWidth,
      height: _memberDetailPageStyles.userInfoPanelHeight,
      padding: EdgeInsets.symmetric(horizontal: _memberDetailPageStyles.widthDp * 30),
      decoration: BoxDecoration(color: Colors.white),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              KeicyNetworkImage(
                url: widget.userModel.avatarUrl,
                width: _memberDetailPageStyles.avatarSize,
                height: _memberDetailPageStyles.avatarSize,
                borderRadius: _memberDetailPageStyles.avatarSize / 2,
                errorWidget: Container(
                  width: _memberDetailPageStyles.avatarSize,
                  height: _memberDetailPageStyles.avatarSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_memberDetailPageStyles.avatarSize / 2),
                    color: Colors.grey[300],
                  ),
                ),
              ),
              SizedBox(height: _memberDetailPageStyles.widthDp * 15),
              Text(
                widget.userModel.name,
                style: TextStyle(
                  fontSize: _memberDetailPageStyles.userNameFontSize,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.userModel.email,
                style: TextStyle(fontSize: _memberDetailPageStyles.emailFontSize, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: _memberDetailPageStyles.widthDp * 5),
              RichText(
                textScaleFactor: 0.9,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: MemberDetailPageString.memberStatusLabel,
                      style: TextStyle(fontSize: _memberDetailPageStyles.otherUserInfoFontSize, color: Colors.black),
                    ),
                    TextSpan(
                      text: (widget.userModel.isPremium) ? "Premiumn" : "Normal",
                      style: TextStyle(fontSize: _memberDetailPageStyles.otherUserInfoFontSize, color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ),
              Text(
                (widget.userModel.isPremium)
                    ? ""
                    : (MemberDetailPageString.expLabel +
                        DateTimeFormat.format(DateTime.fromMillisecondsSinceEpoch(widget.userModel.expTs), format: "m/d/Y")),
                style: TextStyle(fontSize: _memberDetailPageStyles.otherUserInfoFontSize, color: AppColors.primaryColor),
              ),
            ],
          ),
          _containerHeader(context),
        ],
      ),
    );
  }

  Widget _containerHeader(BuildContext context) {
    return Container(
      width: _memberDetailPageStyles.deviceWidth,
      padding: EdgeInsets.symmetric(
        vertical: _memberDetailPageStyles.widthDp * 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: MemberDetailPageString.tabItems.map((item) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: _memberDetailPageStyles.primaryHorizontalPadding,
            ),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 3, color: AppColors.primaryColor))),
            child: Text(item, style: TextStyle(fontSize: _memberDetailPageStyles.textFontSize, fontWeight: FontWeight.bold)),
          );
        }).toList(),
      ),
    );
  }

  Widget _containerFeedList(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
        stream: MemberDetailPageProvider.of(context).userDataStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: KeicyCupertinoIndicator());
          if (snapshot.data.length == 0)
            return Center(
              child: Text("No FeedData", style: TextStyle(fontSize: _memberDetailPageStyles.textFontSize)),
            );

          return ListView.builder(
            itemBuilder: (context, index) {
              FeedModel _feedModel = FeedModel.fromJson(snapshot.data[index]);

              return Container(
                margin: EdgeInsets.symmetric(
                  horizontal: _memberDetailPageStyles.primaryHorizontalPadding,
                  vertical: _memberDetailPageStyles.primaryVerticalPadding,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: _memberDetailPageStyles.primaryHorizontalPadding,
                  vertical: _memberDetailPageStyles.primaryVerticalPadding,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_memberDetailPageStyles.widthDp * 6),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      DateTimeFormat.format(DateTime.fromMillisecondsSinceEpoch(_feedModel.ts), format: "m/d/Y"),
                      style: TextStyle(fontSize: _memberDetailPageStyles.timeFontSize, color: Colors.grey),
                    ),
                    SizedBox(height: _memberDetailPageStyles.widthDp * 5),
                    Text(
                      _feedModel.description,
                      style: TextStyle(fontSize: _memberDetailPageStyles.textFontSize),
                    ),
                    SizedBox(height: _memberDetailPageStyles.widthDp * 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Center(
                            child: KeicyNetworkImage(
                              url: _feedModel.imageUrl,
                              width: _memberDetailPageStyles.imageWidth,
                              height: _memberDetailPageStyles.imageHeight,
                              boxFit: BoxFit.cover,
                            ),
                          ),
                        ),
                        GestureDetector(
                          child: Icon(Icons.delete, size: _memberDetailPageStyles.iconSize, color: Colors.red),
                          onTap: () {
                            _deleteFeed(context, _feedModel.id);
                          },
                        )
                      ],
                    )
                  ],
                ),
              );
            },
            itemCount: snapshot.data.length,
          );
        });
  }

  void _deleteFeed(BuildContext context, String feedID) async {
    await KeicyProgressDialog.of(context).show();
    await FeedDataProvider.deleteFeed(id: feedID);
    KeicyProgressDialog.of(context).hide();
  }
}
