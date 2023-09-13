import 'package:chocsarayi/api/getdata.dart';
import 'package:chocsarayi/data/model/response/product_model.dart';
import 'package:flutter/material.dart';
import 'package:chocsarayi/data/model/response/cart_model.dart';
import 'package:chocsarayi/helper/price_converter.dart';
import 'package:chocsarayi/theme_provider.dart';
import 'package:chocsarayi/utill/color_resources.dart';
import 'package:chocsarayi/utill/dimensions.dart';
import 'package:chocsarayi/utill/styles.dart';
import 'package:chocsarayi/base/rating_bar.dart';
import 'package:chocsarayi/base/title_widget.dart';
import 'package:chocsarayi/screens/home/widget/cart_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';

import '../../../main.dart';


class SetMenuView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SetMenuView();
  }

}


class _SetMenuView extends State<SetMenuView> {
  _SetMenuView(){
    List <Product>setMenuList2=[];
    getalloffers().then((value) {
      print (value);
      for(var p in value) {
        Rating r=new Rating(average: p['rating'],productId: p['id']);
        Product pp = new Product(id:p['id'],name:p['name'],description: p['description'],image: url+"products_gallery/"+ p['img'],price: double.parse(p['price']),rating:[r],addson: [],type: "offer");
        setMenuList2.add(pp);
      }
      setState(() {
        setMenuList=setMenuList2;
      });
    });
  }
  List <Product>setMenuList;
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: TitleWidget(title: 'العروض المتاحة'),
        ),

        SizedBox(
          height: 220,
          child: setMenuList != null ? setMenuList.length > 0 ? ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
            itemCount: setMenuList.length > 5 ? 5 : setMenuList.length,
            itemBuilder: (context, index){

              double _startingPrice;
              double _endingPrice;

              double _discount = setMenuList[index].price - PriceConverter.convertWithDiscount(context,
                  setMenuList[index].price, 0.0, '');

              DateTime _currentTime = DateTime.now();

              bool _isAvailable = true;

              return InkWell(
                onTap: () {
                  showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (con) => CartBottomSheet(
                    product: setMenuList[index], fromSetMenu: true,
                    callback: (CartModel cartModel) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('أضف الى السلة',), backgroundColor: Colors.green));
                    },
                  ));
                },
                child: Container(
                  height: 220,
                  width: 150,
                  margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL, bottom: 5),
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow(
                        color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 700 : 300],
                        blurRadius: 5, spreadRadius: 1,
                      )]
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [

                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                          child: Image.network(
                            setMenuList[index].image,
                            height: 110, width: 150, fit: BoxFit.cover,
                          ),
                        ),
                        _isAvailable ? SizedBox() : Positioned(
                          top: 0, left: 0, bottom: 0, right: 0,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                              color: Colors.black.withOpacity(0.6),
                            ),
                            child: Text('Not available now', textAlign: TextAlign.center, style: rubikRegular.copyWith(
                              color: Colors.white, fontSize: Dimensions.FONT_SIZE_SMALL,
                            )),
                          ),
                        ),
                      ],
                    ),

                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text(
                            setMenuList[index].name,
                            style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
                            maxLines: 2, overflow: TextOverflow.ellipsis,
                          ),

                          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                setMenuList[index].price.toString() ,
                                style: rubikBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
                              ),
                              _discount > 0 ? SizedBox() : Icon(Icons.add, color: Theme.of(context).textTheme.bodyText1.color),
                            ],
                          ),

                        ]),
                      ),
                    ),

                  ]),
                ),
              );
            },
          ) : Center(child: Text('No set menu available')) : SetMenuShimmer(),
        ),
      ],
    );
  }
}

class SetMenuShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
      itemCount: 10,
      itemBuilder: (context, index){
        return Container(
          height: 200,
          width: 150,
          margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL, bottom: 5),
          decoration: BoxDecoration(
              color: ColorResources.COLOR_WHITE,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [BoxShadow(color: Colors.grey[300], blurRadius: 10, spreadRadius: 1)]
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            enabled:true,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

              Container(
                height: 110, width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                    color: ColorResources.COLOR_WHITE
                ),
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(height: 15, width: 130, color: ColorResources.COLOR_WHITE),

                    Align(alignment: Alignment.centerRight, child: RatingBar(rating: 0.0, size: 12)),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Container(height: 10, width: 50, color: ColorResources.COLOR_WHITE),
                      Icon(Icons.add, color: ColorResources.COLOR_BLACK),
                    ]),
                  ]),
                ),
              ),

            ]),
          ),
        );
      },
    );
  }
}

