import 'package:chocsarayi/main.dart';
import 'package:chocsarayi/screens/checkout/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:chocsarayi/data/model/response/product_model.dart';
import 'package:chocsarayi/helper/price_converter.dart';
import 'package:chocsarayi/utill/color_resources.dart';
import 'package:chocsarayi/utill/dimensions.dart';
import 'package:chocsarayi/utill/styles.dart';
import 'package:chocsarayi/base/custom_app_bar.dart';
import 'package:chocsarayi/base/custom_button.dart';
import 'package:chocsarayi/base/custom_divider.dart';
import 'package:chocsarayi/base/custom_snackbar.dart';
import 'package:chocsarayi/base/no_data_screen.dart';
import 'package:chocsarayi/screens/cart/widget/cart_product_widget.dart';
import 'package:chocsarayi/screens/cart/widget/delivery_option_button.dart';
import 'package:provider/provider.dart';


class CartScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return cs();
  }

}

class cs extends State<CartScreen> {



  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final TextEditingController _couponController = TextEditingController();

    return Directionality(textDirection: TextDirection.rtl, child:Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(title:'سلة المشتريات', isBackButtonExist: false),
      body:_build(context)
    ));
  }
  Widget _build(BuildContext context){
    double total=0.0;
       for(var i in cartproducts){
         total=total+i.price;
       }
        double deliveryCharge = 0;
        List<bool> _availableList = [];
        double _itemPrice = 0;
        double _discount = 0;
        double _tax = 0;
        double _addOns = 0;


        return cartproducts.length > 0 ? Column(
          children: [

            Expanded(
              child: ListView(padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL), physics: BouncingScrollPhysics(), children: [

                // Product
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: cartproducts.length,
                  itemBuilder: (context, index) {

                    return CartProductWidget(cart: cartproducts[index], cartIndex: index,refresh: (){
                      setState(() {

                      });
                    },);
                  },
                ),
                // Total


              ]),
            ),



            Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [

                  // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  //   Text('المجموع', style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                  //   Text(total.toString(), style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                  // ]),
                  //
                  // SizedBox(height: 10),
                  //
                  // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  //   Text('اجرة التوصيل', style: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                  //   Text('(+) 0.0', style: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                  // ]),
                  //
                  // Padding(
                  //   padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
                  //   child: CustomDivider(),
                  // ),

                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('المجموع الكلي', style: rubikMedium.copyWith(
                      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE, color: Theme.of(context).primaryColor,
                    )),
                    Text(
                      total.toString(),
                      style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE, color: Theme.of(context).primaryColor),
                    ),
                  ]),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: CustomButton(btnTxt: 'اكمال الطلب', onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => CheckoutScreen(
                  amount: total,
                )));

              }),
            ),
          ],
        ) : NoDataScreen(isCart: true);

  }
}
