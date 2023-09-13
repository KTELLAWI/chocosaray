import 'package:chocsarayi/api/getdata.dart';
import 'package:chocsarayi/data/model/response/product_model.dart';
import 'package:flutter/material.dart';
import 'package:chocsarayi/data/model/response/category_model.dart';
import 'package:chocsarayi/utill/color_resources.dart';
import 'package:chocsarayi/utill/dimensions.dart';
import 'package:chocsarayi/utill/styles.dart';
import 'package:chocsarayi/base/no_data_screen.dart';
import 'package:chocsarayi/base/product_shimmer.dart';
import 'package:chocsarayi/base/product_widget.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class CategoryScreen extends StatefulWidget {
  final int categoryid;
  String title;
  CategoryScreen({@required this.categoryid,this.title});

  @override
  _CategoryScreenState createState() => _CategoryScreenState(categoryid);
}

class _CategoryScreenState extends State<CategoryScreen> with TickerProviderStateMixin {
  final int categoryid;
  _CategoryScreenState(this.categoryid){
    getcategoryproducts(categoryid.toString()).then((value) {
      List <Product>productList2=[];
      for(var p in value) {
        Rating r=new Rating(average: p['product']['rating'],productId: p['product']['id']);
        List addson = p['addon'];
        Product pp = new Product(id:p['product']['id'],name:p['product']['name'],description: "",image: url+"products_gallery/"+ p['product']['img'],price: double.parse(p['product']['price']),rating:[r],addson: addson,type: "product");
        productList2.add(pp);
      }
      setState(() {
        categoryProductList=productList2;
        loading=false;
      });
    });
  }

  List<Product> categoryProductList=[];
  bool loading=true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color(0xFFa54a15),
        title: Text(widget.title,style: TextStyle(color: Colors.white),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body:
        loading?
        ListView.builder(
          itemCount: 10,
          shrinkWrap: true,
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          itemBuilder: (context, index) {
            return ProductShimmer(isEnabled: categoryProductList == null);
          },
        ):
        categoryProductList.length > 0 ? ListView.builder(
          itemCount: categoryProductList.length,
          shrinkWrap: false,
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          itemBuilder: (context, index) {
            return ProductWidget(product: categoryProductList[index]);
          },
        ) : NoDataScreen()

    );
  }


}
