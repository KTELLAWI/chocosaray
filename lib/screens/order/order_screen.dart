import 'package:flutter/material.dart';
import 'package:chocsarayi/utill/color_resources.dart';
import 'package:chocsarayi/utill/dimensions.dart';
import 'package:chocsarayi/utill/styles.dart';
import 'package:chocsarayi/base/custom_app_bar.dart';
import 'package:chocsarayi/screens/order/widget/order_view.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.COLOR_WHITE,
      appBar: CustomAppBar(title: 'طلباتي',isBackButtonExist: false,),
      body: _build(),
    );
  }

  Widget _build(){
    return Column(children: [

      Container(
        color: Theme.of(context).accentColor,
        child: TabBar(
          controller: _tabController,
          labelColor: Theme.of(context).textTheme.bodyText1.color,
          indicatorColor: ColorResources.COLOR_PRIMARY,
          indicatorWeight: 3,
          unselectedLabelStyle: rubikRegular.copyWith(color: ColorResources.COLOR_HINT, fontSize: Dimensions.FONT_SIZE_SMALL),
          labelStyle: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
          tabs: [
            Tab(text: 'الحالية'),
            Tab(text: 'السابقة'),
          ],
        ),
      ),

      Expanded(child: TabBarView(
        controller: _tabController,
        children: [
          OrderView(isRunning: true),
          OrderView(isRunning: false),
        ],
      )),

    ]);

  }
}
