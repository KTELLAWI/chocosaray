import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:chocsarayi/data/model/response/cart_model.dart';
import 'package:chocsarayi/data/model/response/product_model.dart';
import 'package:chocsarayi/helper/price_converter.dart';
import 'package:chocsarayi/theme_provider.dart';
import 'package:chocsarayi/utill/color_resources.dart';
import 'package:chocsarayi/utill/dimensions.dart';
import 'package:chocsarayi/utill/styles.dart';
import 'package:chocsarayi/base/rating_bar.dart';
import 'package:chocsarayi/screens/home/widget/cart_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ProductWidget extends StatelessWidget {
  final Product product;
  ProductWidget({@required this.product});

  @override
  Widget build(BuildContext context) {

    double _startingPrice;
    double _endingPrice;

    double _discountedPrice = PriceConverter.convertWithDiscount(context, product.price, 0.0, '');

    DateTime _currentTime = DateTime.now();

    bool _isAvailable = true;

    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (con) => CartBottomSheet(
              product: product,
              callback: (CartModel cartModel) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('اضف الى السلة'), backgroundColor: Colors.green));
              },
            ),
        );
      },
      child: Container(
        height: 85,
        padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL, horizontal: Dimensions.PADDING_SIZE_SMALL),
        margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(
            color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 700 : 300],
            blurRadius: 5, spreadRadius: 1,
          )],
        ),
        child: Row(children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  product.image,
                  height: 70,
                  width: 85,
                  fit: BoxFit.cover,
                ),
              ),
              _isAvailable ? SizedBox() : Positioned(
                top: 0, left: 0, bottom: 0, right: 0,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.black.withOpacity(0.6)),
                  child: Text('not_available_now_break', textAlign: TextAlign.center, style: rubikRegular.copyWith(
                    color: Colors.white, fontSize: 8,
                  )),
                ),
              ),
            ],
          ),
          SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(product.name, style: rubikMedium, maxLines: 2, overflow: TextOverflow.ellipsis),
              SizedBox(height: 10),
            Text(product.price.toString(), style: rubikMedium.copyWith(
                color: ColorResources.COLOR_GREY,
                fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
              )) ,
            ]),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Icon(Icons.add),
            Expanded(child: SizedBox()),
          ]),
        ]),
      ),
    );
  }
}
