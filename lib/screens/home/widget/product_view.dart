import 'package:chocsarayi/api/getdata.dart';
import 'package:flutter/material.dart';
import 'package:chocsarayi/data/model/response/product_model.dart';
import 'package:chocsarayi/helper/product_type.dart';
import 'package:chocsarayi/utill/dimensions.dart';
import 'package:chocsarayi/base/no_data_screen.dart';
import 'package:chocsarayi/base/product_shimmer.dart';
import 'package:chocsarayi/base/product_widget.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';


class ProductView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductView();
  }

}


class _ProductView extends State<ProductView> {

  _ProductView(){
    List <Product>productList2=[];
    getfetproducts().then((value) {
      for(var p in value) {
        Rating r=new Rating(average: p['product']['rating'],productId: p['product']['id']);
        List addson = p['addon'];
        Product pp = new Product(id:p['product']['id'],name:p['product']['name'],description: p['product']['info'],image: url+"products_gallery/"+ p['product']['img'],price: double.parse(p['product']['price']),rating:[r],addson: addson,category: p['product']['category_id'].toString(),type: "product");
        productList2.add(pp);
      }
    setState(() {
      productList=productList2;
      isLoading=false;
    });
    });
  }


  List <Product>productList=[];
  bool isLoading=true;


  @override
  Widget build(BuildContext context) {

    return Column(children: [

      isLoading? ListView.builder(
        itemCount: 10,
        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return ProductShimmer(isEnabled: productList == null);
        },
      ):
       productList.length > 0 ? ListView.builder(
        itemCount: productList.length,
        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
        shrinkWrap: true,
        physics:NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return ProductWidget(product: productList[index]);
        },
      ) : NoDataScreen()



    ]);
  }
}
