import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:keicy_network_image/keicy_network_image.dart';
import 'package:keicy_text_form_field/keicy_text_form_field.dart';
import 'package:provider/provider.dart';

import 'package:image_picker/image_picker.dart';

import 'index.dart';
import 'package:asami_admin_app/Pages/App/index.dart';
import 'package:asami_backend/Models/index.dart';

class OrderFulfillPage extends StatefulWidget {
  @override
  _OrderFulfillPageState createState() => _OrderFulfillPageState();
}

class _OrderFulfillPageState extends State<OrderFulfillPage> {
  OrderFulfillPageStyles _orderFulfillPageStyles;
  TabController _tabController;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _orderFulfillPageStyles = OrderFulfillPageMobileStyles(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OrderFulfillPageProvider()),
      ],
      child: Builder(builder: (context) {
        return _containerMain(context);
      }),
    );
  }

  Widget _containerMain(BuildContext context) {
    return DefaultTabController(
      length: OrderFulfillPageString.tabItems.length,
      child: Scaffold(
        backgroundColor: OrderFulfillPageColors.backColor,
        appBar: _containerAppBar(context),
        body: TabBarView(
          controller: _tabController,
          children: [
            _containerOrderTabView(context),
            _containerOrderTabView(context),
          ],
        ),
      ),
    );
  }

  Widget _containerAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          GestureDetector(
            child: Icon(Icons.arrow_back_ios, size: _orderFulfillPageStyles.iconSize, color: Colors.black),
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
          OrderFulfillPageString.appbarTitle,
          style: TextStyle(
            fontSize: _orderFulfillPageStyles.appbarTitleFontSize,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(Icons.arrow_back_ios, size: _orderFulfillPageStyles.iconSize, color: Colors.transparent),
            Icon(Icons.arrow_back_ios, size: _orderFulfillPageStyles.iconSize, color: Colors.transparent),
          ],
        )
      ],
      bottom: TabBar(
        controller: _tabController,
        labelStyle: TextStyle(fontSize: _orderFulfillPageStyles.textFontSize, fontWeight: FontWeight.bold),
        labelColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: AppColors.primaryColor,
        indicatorWeight: 5,
        tabs: OrderFulfillPageString.tabItems.map((item) => Text(item)).toList(),
      ),
      elevation: 0,
    );
  }

  Widget _containerOrderTabView(BuildContext context) {
    return Container(
      width: _orderFulfillPageStyles.deviceWidth,
      height: _orderFulfillPageStyles.safeAreaHeight,
      padding: EdgeInsets.symmetric(
        vertical: _orderFulfillPageStyles.primaryVerticalPadding,
      ),
      child: Consumer<OrderFulfillPageProvider>(builder: (context, postFeedPageProvider, _) {
        return Column(
          children: <Widget>[
            _containerSearchField(context),
            SizedBox(height: _orderFulfillPageStyles.widthDp * 30),
            Expanded(
              child: _containerMemberList(context),
            ),
          ],
        );
      }),
    );
  }

  Widget _containerSearchField(BuildContext context) {
    return Container(
      width: _orderFulfillPageStyles.deviceWidth,
      padding: EdgeInsets.symmetric(horizontal: _orderFulfillPageStyles.primaryHorizontalPadding),
      child: KeicyTextFormField(
        width: double.infinity,
        height: _orderFulfillPageStyles.searchFieldHeight,
        controller: _textEditingController,
        fixedHeightState: false,
        border: Border.all(width: 0),
        borderRadius: _orderFulfillPageStyles.widthDp * 6,
        textFontSize: _orderFulfillPageStyles.textFontSize,
        suffixIcons: <Widget>[
          GestureDetector(
            child: Icon(Icons.search, size: _orderFulfillPageStyles.iconSize),
            onTap: () {
              if (_textEditingController.text == "") return;
            },
          )
        ],
      ),
    );
  }

  Widget _containerMemberList(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        UserModel _userModel = UserModel();
        _userModel.name = "John Doe";
        _userModel.email = "name@email.com";
        _userModel.avatarUrl = "https://image.cnbcfm.com/api/v1/image/105942823-1559316885766gettyimages-1066957624.jpeg?v=1581707955&w=678&h=381";

        return Container(
          width: double.infinity,
          height: _orderFulfillPageStyles.memberItemHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(_orderFulfillPageStyles.widthDp * 6),
          ),
          margin: EdgeInsets.symmetric(horizontal: _orderFulfillPageStyles.primaryHorizontalPadding),
          padding: EdgeInsets.symmetric(horizontal: _orderFulfillPageStyles.memberItemHorizontalPadding),
          child: Row(
            children: <Widget>[
              KeicyNetworkImage(
                url: _userModel.avatarUrl,
                width: _orderFulfillPageStyles.avatarSize,
                height: _orderFulfillPageStyles.avatarSize,
                borderRadius: _orderFulfillPageStyles.avatarSize / 2,
                errorWidget: Container(
                  width: _orderFulfillPageStyles.avatarSize,
                  height: _orderFulfillPageStyles.avatarSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_orderFulfillPageStyles.avatarSize / 2),
                    color: OrderFulfillPageColors.avatarBackColor,
                  ),
                ),
              ),
              SizedBox(width: _orderFulfillPageStyles.widthDp * 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _userModel.name,
                      style: TextStyle(fontSize: _orderFulfillPageStyles.textFontSize, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _userModel.email,
                      style: TextStyle(fontSize: _orderFulfillPageStyles.emailFontSize, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: _orderFulfillPageStyles.widthDp * 30);
      },
      itemCount: 20,
    );
  }
}
