import 'package:flutter/material.dart';
import 'package:chocsarayi/theme_provider.dart';
import 'package:chocsarayi/utill/color_resources.dart';
import 'package:chocsarayi/utill/dimensions.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class OrderShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            boxShadow: [BoxShadow(
              color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 700 : 300],
              spreadRadius: 1, blurRadius: 5,
            )],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            enabled: true,
            child: Column(children: [

              Row(children: [
                Container(
                  height: 70, width: 80,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                ),
                SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(height: 15, width: 150, color: Colors.white),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  Container(height: 15, width: 100, color: Colors.white),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  Container(height: 15, width: 130, color: Colors.white),
                ]),
              ]),
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

              Row(children: [
                Expanded(child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2, color: ColorResources.DISABLE_COLOR),
                  ),
                )),
                SizedBox(width: 20),
                Expanded(child: Container(
                  height: 50,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                )),
              ]),

            ]),
          ),
        );
      },
    );
  }
}
