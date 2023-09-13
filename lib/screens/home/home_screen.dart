import 'package:chocsarayi/api/getdata.dart';
import 'package:chocsarayi/main.dart';
import 'package:chocsarayi/screens/notification/notification_screen.dart';
import 'package:chocsarayi/screens/search/search_result_screen.dart';
import 'package:chocsarayi/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:chocsarayi/helper/product_type.dart';
import 'package:chocsarayi/utill/color_resources.dart';
import 'package:chocsarayi/utill/dimensions.dart';
import 'package:chocsarayi/utill/images.dart';
import 'package:chocsarayi/utill/styles.dart';
import 'package:chocsarayi/base/title_widget.dart';
import 'package:chocsarayi/screens/home/widget/banner_view.dart';
import 'package:chocsarayi/screens/home/widget/category_view.dart';
import 'package:chocsarayi/screens/home/widget/product_view.dart';
import 'package:chocsarayi/screens/home/widget/set_menu_view.dart';
import 'package:provider/provider.dart';

import '../../firebase.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return _HomeScreen();
  }

}


class _HomeScreen extends State<HomeScreen> {

  _HomeScreen(){

   getmaincategories().then((value) {
     print(value);
   });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // PushNotificationsManager fcm= new PushNotificationsManager();
    // fcm.init();
  }


  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
List categoryList;
    return Directionality(textDirection:TextDirection.rtl , child:
    Scaffold(
      backgroundColor: ColorResources.getBackgroundColor(context),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {

          },
          backgroundColor: Theme.of(context).primaryColor,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [

              // App Bar
              SliverAppBar(
                floating: true,
                elevation: 0,
                centerTitle: false,
                automaticallyImplyLeading: false,
                backgroundColor: Theme.of(context).accentColor,
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(Images.logonew, width: 70, height: 50),
                    SizedBox(width: 10),
                    Image.asset(Images.name, width: 100, height: 55, color: ColorResources.getPrimaryColor(context)),
                    Spacer(),
                    Text(bransh_name,style: TextStyle(color: Colors.black,fontSize: 16),),
                    SizedBox(width: 10),
                  ],
                ),
                actions: [
                  // IconButton(
                  //   onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NotificationScreen())),
                  //   icon: Icon(Icons.notifications, color: Theme.of(context).textTheme.bodyText1.color),
                  // ),
                ],
              ),

              // Search Button
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverDelegate(child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchResultScreen()));
                  },
                  child: Container(
                    height: 50,
                    color: Theme.of(context).accentColor,
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: 2),
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorResources.getSearchBg(context),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(children: [
                        Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL), child: Icon(Icons.search, size: 25)),
                        Expanded(child: Text('اضغط هنا للبحث', style: rubikRegular.copyWith(fontSize: 12))),
                      ]),
                    ),
                  ),
                )),
              ),
              SliverToBoxAdapter(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  CategoryView(),
                  SetMenuView(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                    child: TitleWidget(title: 'العناصر المميزة'),
                  ),
                  ProductView(),

                ]),
              ),
            ],
          ),
        ),
      ),
    )

    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;

  SliverDelegate({@required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 50 || oldDelegate.minExtent != 50 || child != oldDelegate.child;
  }
}
