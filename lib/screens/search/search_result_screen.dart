import 'package:chocsarayi/api/getdata.dart';
import 'package:chocsarayi/data/model/response/product_model.dart';
import 'package:flutter/material.dart';
import 'package:chocsarayi/utill/color_resources.dart';
import 'package:chocsarayi/utill/dimensions.dart';
import 'package:chocsarayi/utill/images.dart';
import 'package:chocsarayi/base/custom_text_field.dart';
import 'package:chocsarayi/base/no_data_screen.dart';
import 'package:chocsarayi/base/product_shimmer.dart';
import 'package:chocsarayi/base/product_widget.dart';
import 'package:chocsarayi/screens/search/widget/filter_widget.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class SearchResultScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SearchResultScreen();
  }

}


class _SearchResultScreen extends State<SearchResultScreen> {


  List<Product>searchProductList =[];
  TextEditingController _searchController = TextEditingController();
  int atamp = 0;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hintText: 'اكتب عنصر للبحث',
                        isShowBorder: true,
                        // isShowSuffixIcon: true,
                       // suffixIconUrl: Images.filter,
                        controller: _searchController,
                        isShowPrefixIcon: true,
                        prefixIconUrl: Images.search,
                        inputAction: TextInputAction.search,
                        isIcon: true,
                        onSuffixTap: () {
                          // showDialog(
                          //     context: context,
                          //     builder: (BuildContext context) {
                          //       List<double> _prices = [];
                          //       _prices.sort();
                          //       double _maxValue = 1000;
                          //       return Dialog(
                          //         shape: RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(20.0)),
                          //         child: FilterWidget(maxValue: _maxValue),
                          //       );
                          //     });

                        },
                        onChanged: (val){
                          getsearchproducts(val).then((value) {
                            List <Product>productList2=[];
                            for(var p in value) {
                              Rating r=new Rating(average: p['product']['rating'],productId: p['product']['id']);
                              List addson = p['addon'];
                              Product pp = new Product(id:p['product']['id'],name:p['product']['name'],description: "",image: url+"products_gallery/"+ p['product']['img'],price: double.parse(p['product']['price']),rating:[r],addson: addson,type: "product");
                              productList2.add(pp);
                            }
                            setState(() {
                              searchProductList=productList2;
                            });
                          });
                        },
                        onSubmit: (val){
                          // getsearchproducts(val).then((value) {
                          //   List <Product>productList2=[];
                          //   for(var p in value) {
                          //   Rating r=new Rating(average: p['product']['rating'],productId: p['product']['id']);
                          //   List addson = p['addon'];
                          //   Product pp = new Product(id:p['product']['id'],name:p['product']['name'],description: "",image: url+"products_gallery/"+ p['product']['img'],price: double.parse(p['product']['price']),rating:[r],addson: addson);
                          //   productList2.add(pp);
                          //   }
                          //   setState(() {
                          //     searchProductList=productList2;
                          //   });
                          // });
                        },
                      ),
                    ),
                    SizedBox(width: 12),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 10,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 13),
                Expanded(
                  child: searchProductList != null
                      ? searchProductList.length > 0
                      ? ListView.builder(
                      itemCount: searchProductList.length,
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      itemBuilder: (context, index) => ProductWidget(product: searchProductList[index]))
                      : NoDataScreen()
                      : ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) => ProductShimmer(isEnabled:searchProductList == null),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
