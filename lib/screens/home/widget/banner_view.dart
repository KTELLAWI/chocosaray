import 'package:chocsarayi/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:chocsarayi/data/model/response/cart_model.dart';
import 'package:chocsarayi/data/model/response/category_model.dart';
import 'package:chocsarayi/data/model/response/product_model.dart';
import 'package:chocsarayi/utill/color_resources.dart';
import 'package:chocsarayi/utill/dimensions.dart';
import 'package:chocsarayi/base/title_widget.dart';
import 'package:chocsarayi/screens/home/widget/cart_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class BannerView extends StatelessWidget {
  List banners=[];
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: TitleWidget(title: 'Banner'),
        ),

        SizedBox(
          height: 85,
          child: bannerwid()
        ),
      ],
    );
  }

  Widget bannerwid(){

        return banners != null ? banners.length > 0 ? ListView.builder(
          itemCount: banners.length,
          padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {

              },
              child: Container(
                margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(
                      color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 700 : 300],
                      spreadRadius: 1, blurRadius: 5),
                  ],
                  color: ColorResources.COLOR_WHITE,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    banners[index].image,
                    width: 250, height: 85, fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ) : Center(child: Text('No banner available')) : BannerShimmer();
  }

}

class BannerShimmer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Container(
            width: 250, height: 85,
            margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.grey[200], spreadRadius: 1, blurRadius: 5)],
              color: ColorResources.COLOR_WHITE,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
    );
  }
}

