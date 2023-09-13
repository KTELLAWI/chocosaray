import 'package:chocsarayi/main.dart';
import 'package:flutter/material.dart';
import 'package:chocsarayi/data/model/response/cart_model.dart';
import 'package:chocsarayi/data/model/response/product_model.dart';
import 'package:chocsarayi/helper/price_converter.dart';
import 'package:chocsarayi/utill/color_resources.dart';
import 'package:chocsarayi/utill/dimensions.dart';
import 'package:chocsarayi/utill/styles.dart';
import 'package:chocsarayi/base/rating_bar.dart';
import 'package:chocsarayi/screens/home/widget/cart_bottom_sheet.dart';
import 'package:provider/provider.dart';


class CartProductWidget extends StatefulWidget{
  final CartModel cart;
  final int cartIndex;
  final Function refresh;
  CartProductWidget({@required this.cart, @required this.cartIndex,this.refresh});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return cw(cart: cart,cartIndex: cartIndex);
  }

}

class cw extends State<CartProductWidget> {
  final CartModel cart;
  final int cartIndex;

  cw({@required this.cart, @required this.cartIndex});
  List <Widget> ads=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(var i in cart.product.addson ){
      if(i['added'].toString()=="1") {
        ads.add(
          Text(i['name'] + " , ", style: rubikMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
        );
        ads.add(SizedBox(width: 7,));
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // showModalBottomSheet(
        //   context: context,
        //   isScrollControlled: true,
        //   backgroundColor: Colors.transparent,
        //   builder: (con) => CartBottomSheet(
        //     product: cart.product,
        //     cartIndex: cartIndex,
        //     cart: cart,
        //     callback: (CartModel cartModel) {
        //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated('updated_in_cart', context)), backgroundColor: Colors.green));
        //     },
        //   ),
        // );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_DEFAULT),
        decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
        child: Stack(children: [

         Container(
              padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL, horizontal: Dimensions.PADDING_SIZE_SMALL),
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 5, spreadRadius: 1,
                )],
              ),
              child: Column(
                children: [
                  SizedBox(height: 7),
                  Row(children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            cart.product.image,
                            height: 70, width: 85, fit: BoxFit.cover,
                          ),
                        ),

                      ],
                    ),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text(cart.product.name, style: rubikMedium, maxLines: 2, overflow: TextOverflow.ellipsis),
                        SizedBox(height: 2),
                        Row(children: ads,),
                        SizedBox(height: 2),
                        RatingBar(rating: cart.product.rating.length > 0 ? double.parse(cart.product.rating[0].average) : 0.0, size: 12),
                        SizedBox(height: 5),
                      ]),
                    ),

                    Container(
                      decoration: BoxDecoration(color: ColorResources.getBackgroundColor(context), borderRadius: BorderRadius.circular(5)),
                      child: Row(children: [
                        InkWell(
                          onTap: () {
                            if (cart.quantity > 1) {
                            setState(() {
                              double unit_price=cartproducts[cartIndex].price/cartproducts[cartIndex].quantity;
                              cartproducts[cartIndex].quantity=cartproducts[cartIndex].quantity-1;
                              cartproducts[cartIndex].price= unit_price* cartproducts[cartIndex].quantity;
                              widget.refresh();
                            });
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: Icon(Icons.remove, size: 20),
                          ),
                        ),
                        Text(cart.quantity.toString(), style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE)),
                        InkWell(
                          onTap: () {
                            setState(() {
                              double unit_price=cartproducts[cartIndex].price/cartproducts[cartIndex].quantity;
                              cartproducts[cartIndex].quantity=cartproducts[cartIndex].quantity+1;
                              cartproducts[cartIndex].price= unit_price* cartproducts[cartIndex].quantity;
                              widget.refresh();
                            });
                          }
                          ,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: Icon(Icons.add, size: 20),
                          ),
                        ),
                      ]),
                    ),

                  ]),
                  SizedBox(),

                ],
              ),
            ),
          Container(
            padding: EdgeInsets.only(left: 10,top: 5),
            alignment: Alignment.centerLeft,
            child: InkWell(
              child: Icon(Icons.delete, color: Colors.grey, size: 23),
              onTap: (){
                cartproducts.removeAt(cartIndex);
                widget.refresh();
              },
            ),
          )
        ]),
      ),
    );
  }
}
