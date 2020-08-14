import 'dart:async';
import 'dart:io';

import 'package:asami_app/Pages/MemberDetailPage/member_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:keicy_cupertino_indicator/keicy_cupertino_indicator.dart';
import 'package:keicy_network_image/keicy_network_image.dart';
import 'package:keicy_text_form_field/keicy_text_form_field.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:image_picker/image_picker.dart';

import 'index.dart';
import 'package:asami_app/Pages/App/index.dart';
import 'package:asami_backend/Models/index.dart';

class MembersPage extends StatefulWidget {
  @override
  _MembersPageState createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  MembersPageStyles _membersPageStyles;
  TabController _tabController;
  Map<String, TextEditingController> _textEditingController = Map<String, TextEditingController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _membersPageStyles = MembersPageMobileStyles(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MembersPageProvider()),
      ],
      child: Builder(builder: (context) {
        return _containerMain(context);
      }),
    );
  }

  Widget _containerMain(BuildContext context) {
    if (MembersPageProvider.of(context).userListStream == null) MembersPageProvider.of(context).getUserListStream();

    return Consumer<MembersPageProvider>(builder: (context, membersPageProvider, _) {
      return DefaultTabController(
        length: MembersPageString.tabItems.length,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: MembersPageColors.backColor,
            appBar: _containerAppBar(context),
            body: StreamBuilder<Object>(
                stream: MembersPageProvider.of(context).userListStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Center(child: KeicyCupertinoIndicator());

                  List<Map<String, dynamic>> _userList = snapshot.data;

                  if (_userList.length == 0)
                    return Center(
                      child: Text("No Members", style: TextStyle(fontSize: _membersPageStyles.textFontSize)),
                    );

                  return TabBarView(
                    controller: _tabController,
                    children: MembersPageString.tabItems.map((item) => _containerTabView(context, membersPageProvider, _userList, item)).toList(),
                  );
                }),
          ),
        ),
      );
    });
  }

  Widget _containerAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          GestureDetector(
            child: Icon(Icons.arrow_back_ios, size: _membersPageStyles.iconSize, color: Colors.black),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      centerTitle: true,
      title: Container(
        height: kBottomNavigationBarHeight,
        alignment: Alignment.bottomCenter,
        child: Text(
          MembersPageString.appbarTitle,
          style: TextStyle(
            fontSize: _membersPageStyles.appbarTitleFontSize,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(Icons.arrow_back_ios, size: _membersPageStyles.iconSize, color: Colors.transparent),
            Icon(Icons.arrow_back_ios, size: _membersPageStyles.iconSize, color: Colors.transparent),
          ],
        )
      ],
      bottom: TabBar(
        controller: _tabController,
        labelStyle: TextStyle(fontSize: _membersPageStyles.textFontSize, fontWeight: FontWeight.bold),
        labelColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: AppColors.primaryColor,
        indicatorWeight: 5,
        tabs: MembersPageString.tabItems.map((item) => Text(item)).toList(),
      ),
      elevation: 0,
    );
  }

  Widget _containerTabView(BuildContext context, MembersPageProvider membersPageProvider, List<Map<String, dynamic>> userList, String memberType) {
    List<UserModel> _userModelList = [];
    if (_textEditingController[memberType] == null) _textEditingController[memberType] = TextEditingController();

    switch (memberType) {
      case "All":
        for (var i = 0; i < userList.length; i++) {
          if (_textEditingController[memberType].text == null) {
            _userModelList.add(UserModel.fromJson(userList[i]));
          } else if (_textEditingController[memberType].text != null && userList[i]["name"].contains(_textEditingController[memberType].text)) {
            _userModelList.add(UserModel.fromJson(userList[i]));
          }
        }
        break;
      case "Premium":
        for (var i = 0; i < userList.length; i++) {
          if (userList[i]["isPremium"] && _textEditingController[memberType].text == null) {
            _userModelList.add(UserModel.fromJson(userList[i]));
          } else if (userList[i]["isPremium"] &&
              _textEditingController[memberType].text != null &&
              userList[i]["name"].contains(_textEditingController[memberType].text)) {
            _userModelList.add(UserModel.fromJson(userList[i]));
          }
        }
        break;
      case "Expired":
        for (var i = 0; i < userList.length; i++) {
          if (!userList[i]["isPremium"] && _textEditingController[memberType].text == null) {
            _userModelList.add(UserModel.fromJson(userList[i]));
          } else if (!userList[i]["isPremium"] &&
              _textEditingController[memberType].text != null &&
              userList[i]["name"].contains(_textEditingController[memberType].text)) {
            _userModelList.add(UserModel.fromJson(userList[i]));
          }
        }
        break;
      default:
    }
    return Container(
      width: _membersPageStyles.deviceWidth,
      height: _membersPageStyles.safeAreaHeight,
      padding: EdgeInsets.symmetric(
        vertical: _membersPageStyles.primaryVerticalPadding,
      ),
      child: Consumer<MembersPageProvider>(builder: (context, postFeedPageProvider, _) {
        return Column(
          children: <Widget>[
            _containerSearchField(context, membersPageProvider, memberType),
            SizedBox(height: _membersPageStyles.widthDp * 30),
            Expanded(
              child: _containerMemberList(context, membersPageProvider, _userModelList),
            ),
          ],
        );
      }),
    );
  }

  Widget _containerSearchField(BuildContext context, MembersPageProvider membersPageProvider, String memberType) {
    return Container(
      width: _membersPageStyles.deviceWidth,
      padding: EdgeInsets.symmetric(horizontal: _membersPageStyles.primaryHorizontalPadding),
      child: KeicyTextFormField(
        width: double.infinity,
        height: _membersPageStyles.searchFieldHeight,
        controller: _textEditingController[memberType],
        fixedHeightState: false,
        border: Border.all(width: 0, color: Colors.white),
        borderRadius: _membersPageStyles.widthDp * 6,
        textFontSize: _membersPageStyles.textFontSize,
        contentHorizontalPadding: _membersPageStyles.widthDp * 10,
        suffixIcons: <Widget>[
          GestureDetector(
            child: Icon(Icons.search, size: _membersPageStyles.iconSize),
            onTap: () {
              if (_textEditingController[memberType].text == "") return;
              membersPageProvider.refresh();
            },
          )
        ],
      ),
    );
  }

  Widget _containerMemberList(BuildContext context, MembersPageProvider membersPageProvider, List<UserModel> userModelList) {
    return ListView.separated(
      itemBuilder: (context, index) {
        UserModel _userModel = userModelList[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => MemberDetailPage(userModel: _userModel),
              ),
            );
          },
          child: Container(
            width: double.infinity,
            height: _membersPageStyles.memberItemHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(_membersPageStyles.widthDp * 6),
            ),
            margin: EdgeInsets.symmetric(horizontal: _membersPageStyles.primaryHorizontalPadding),
            padding: EdgeInsets.symmetric(horizontal: _membersPageStyles.memberItemHorizontalPadding),
            child: Row(
              children: <Widget>[
                KeicyNetworkImage(
                  url: _userModel.avatarUrl,
                  width: _membersPageStyles.avatarSize,
                  height: _membersPageStyles.avatarSize,
                  borderRadius: _membersPageStyles.avatarSize / 2,
                  errorWidget: ClipRRect(
                    borderRadius: BorderRadius.circular(_membersPageStyles.avatarSize / 2),
                    child: Image.asset(
                      AppAssets.avatarImage,
                      width: _membersPageStyles.avatarSize,
                      height: _membersPageStyles.avatarSize,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: _membersPageStyles.widthDp * 20),
                Expanded(
                  child: Container(
                    height: _membersPageStyles.avatarSize,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _userModel.name,
                          style: TextStyle(fontSize: _membersPageStyles.textFontSize, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          _userModel.email,
                          style: TextStyle(fontSize: _membersPageStyles.emailFontSize, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: _membersPageStyles.widthDp * 30);
      },
      itemCount: userModelList.length,
    );
  }
}
