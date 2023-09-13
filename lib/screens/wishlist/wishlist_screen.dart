import 'package:chocsarayi/api/getdata.dart';
import 'package:chocsarayi/data/model/response/product_model.dart';
import 'package:chocsarayi/db/db.dart';
import 'package:flutter/material.dart';
import 'package:chocsarayi/utill/color_resources.dart';
import 'package:chocsarayi/utill/dimensions.dart';
import 'package:chocsarayi/base/custom_app_bar.dart';
import 'package:chocsarayi/base/no_data_screen.dart';
import 'package:chocsarayi/base/product_widget.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class WishListScreen extends StatefulWidget {
  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {

  _WishListScreenState(){
    List <Product>wishList2=[];
    if(user!=null) {
      getmyfavorate(user['userid']).then((value) {
        for (var p in value) {
          Rating r = new Rating(
              average: p['product']['rating'], productId: p['product']['id']);
          List addson = p['addon'];
          Product pp = new Product(id: p['product']['id'],
              name: p['product']['name'],
              description: "",
              image: url + "products_gallery/" + p['product']['img'],
              price: double.parse(p['product']['price']),
              rating: [r],
              addson: addson,
              category: "",
              type: "product");
          wishList2.add(pp);
        }
        setState(() {
          wishList = wishList2;
        });
      });
    }
  }

  List <Product>wishList=[];
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(
        appBar: CustomAppBar(title: 'المفضلة', isBackButtonExist: false),
        body: _build()
    ));
  }
  Widget _build(){
    return wishList != null ? wishList.length > 0 ? RefreshIndicator(
      onRefresh: () async {
        // await Provider.of<WishListProvider>(context, listen: false).initWishList();
      },
      backgroundColor: Theme.of(context).primaryColor,
      child: ListView.builder(
        itemCount: wishList.length,
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        itemBuilder: (context, index) {
          return ProductWidget(product: wishList[index]);
        },
      ),
    ): NoDataScreen()
        : Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(ColorResources.COLOR_PRIMARY)));
  }
}
