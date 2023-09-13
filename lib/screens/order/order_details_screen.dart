import 'package:chocsarayi/api/getdata.dart';
import 'package:chocsarayi/main.dart';
import 'package:flutter/material.dart';
import 'package:chocsarayi/data/model/response/address_model.dart';
import 'package:chocsarayi/data/model/response/order_details_model.dart';
import 'package:chocsarayi/data/model/response/product_model.dart';
import 'package:chocsarayi/data/model/response/order_model.dart';
import 'package:chocsarayi/helper/date_converter.dart';
import 'package:chocsarayi/helper/price_converter.dart';
import 'package:chocsarayi/utill/color_resources.dart';
import 'package:chocsarayi/utill/dimensions.dart';
import 'package:chocsarayi/utill/styles.dart';
import 'package:chocsarayi/base/custom_app_bar.dart';
import 'package:chocsarayi/base/custom_button.dart';
import 'package:chocsarayi/base/custom_divider.dart';
import 'package:chocsarayi/screens/order/widget/change_method_dialog.dart';
import 'package:chocsarayi/screens/order/widget/order_cancel_dialog.dart';
import 'package:provider/provider.dart';


class OrderDetailsScreen extends StatefulWidget{
  final OrderModel orderModel;
  final int orderId;
  OrderDetailsScreen({@required this.orderModel, @required this.orderId});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return _OrderDetailsScreen(orderModel: orderModel, orderId: orderId);
  }

}


class _OrderDetailsScreen extends State<OrderDetailsScreen> {
  final OrderModel orderModel;
  final int orderId;
  List orderDetails ;
  _OrderDetailsScreen({@required this.orderModel, @required this.orderId}){
    getorderdetails(orderId.toString()).then((value) {
     List products=value['products'];
     List orderDetails2=[] ;
     double amount=0;
     for(var p in products){
       Rating r=new Rating(average: p['product']['rating'],productId: p['product']['id']);
       List addson = p['addson'];
       double ads=0;
       for(var ad in addson){
         ads=ads+double.parse(ad['price'].toString());
       }
       Product pp = new Product(id:p['product']['id'],name:p['product']['name'],description: "",image: url+"products_gallery/"+ p['product']['img'],price: double.parse(p['product']['price']),rating:[r],addson: addson,category: p['product']['category_id'].toString(),type: "product");
       OrderDetailsModel od= new OrderDetailsModel(orderId: orderId,productId:p['product']['id'],price:double.parse(p['product']['price'])+ads,productDetails: pp,quantity: int.parse(p['quantity']),createdAt: p['product']['created_at'],updatedAt: p['product']['updated_at']  );
       orderDetails2.add(od);
       amount=amount+double.parse(p['product']['price'])+ads;
     }
     setState(() {
       orderDetails=orderDetails2;
       amountss=amount.toString();
     });
    });
  }

  final GlobalKey<ScaffoldState> _scaffold = GlobalKey();

 String amountss="";
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      key: _scaffold,
      appBar: CustomAppBar(title: 'تفاصيل الطلب'),
      body:Directionality(
        textDirection: TextDirection.rtl,
        child: _build(context),
      ),
    );
  }
  Widget _build(BuildContext context){
        return orderDetails != null ? Column(
          children: [
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                children: [
                  Row(children: [
                    Text('رقم الطلب : ', style: rubikRegular),
                    SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    Text(orderId.toString(), style: rubikMedium),
                    SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    Expanded(child: SizedBox()),
                    // Icon(Icons.watch_later, size: 17),
                    // SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    // Text(DateConverter.isoStringToLocalDateOnly(order.trackModel.createdAt), style: rubikRegular),
                  ]),
                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                  Row(children: [
                    Text('العناصر : ', style: rubikRegular),
                    SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    Text(orderModel.count, style: rubikMedium.copyWith(color: Theme.of(context).primaryColor)),
                    Expanded(child: SizedBox()),

                  ]),
                  Divider(height: 40),

                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: orderDetails.length,
                    itemBuilder: (context, index) {
                      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Row(children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              orderDetails[index].productDetails.image,
                              height: 70,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                          Expanded(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      orderDetails[index].productDetails.name,
                                      style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text('العدد : ', style: rubikRegular),
                                  Text(orderDetails[index].quantity.toString(), style: rubikMedium.copyWith(color: Theme.of(context).primaryColor)),
                                ],
                              ),
                              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              Row(children: [
                                Text(
                                  PriceConverter.convertPrice(context, orderDetails[index].price ),
                                  style: rubikBold,
                                ),
                              SizedBox(),
                              ]),
                              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                              Row(children: [
                                Container(height: 10, width: 10, decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).textTheme.bodyText1.color,
                                )),
                                SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                Text(
                                  orderDetails[index].createdAt,
                                  style: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
                                ),
                              ]),
                            ]),
                          ),
                        ]),

                        Divider(height: 40),
                      ]);
                    },
                  ),

                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('المجموع : '+amountss , style: rubikMedium.copyWith(
                      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE, color: Theme.of(context).primaryColor,
                    )),
                    // Text(
                    //   PriceConverter.convertPrice(context, _total),
                    //   style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE, color: Theme.of(context).primaryColor),
                    // ),
                  ]),
                  //
                  (orderModel.orderNote!= null && orderModel.orderNote.isNotEmpty) ? Container(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_LARGE),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: ColorResources.getGreyColor(context)),
                    ),
                    child: Text(orderModel.orderNote, style: rubikRegular.copyWith(color: ColorResources.getGreyColor(context))),
                  ) : SizedBox(),

                ],
              ),
            ),
            //
            orderModel.orderStatus=="canceled"?Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('تم الغاء الطلب', style: rubikBold.copyWith(color: Theme.of(context).primaryColor)),
            ):SizedBox(),



            orderModel.orderStatus == 'delivered' ? Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: CustomButton(
                btnTxt: 'تقييم',
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(builder: (_) => RateReviewScreen(
                  //   orderDetailsList: order.orderDetails,
                  //   deliveryMan: order.trackModel.deliveryMan,
                  // )));
                },
              ),
            ) : SizedBox(),

          ],
        ) : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)));

  }
}
