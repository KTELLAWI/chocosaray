import 'package:chocsarayi/api/getdata.dart';
import 'package:flutter/material.dart';
import 'package:chocsarayi/data/model/response/cart_model.dart';
import 'package:chocsarayi/data/model/response/order_details_model.dart';
import 'package:chocsarayi/data/model/response/order_model.dart';
import 'package:chocsarayi/helper/price_converter.dart';
import 'package:chocsarayi/utill/color_resources.dart';
import 'package:chocsarayi/utill/dimensions.dart';
import 'package:chocsarayi/utill/images.dart';
import 'package:chocsarayi/utill/styles.dart';
import 'package:chocsarayi/base/custom_button.dart';
import 'package:chocsarayi/base/no_data_screen.dart';
import 'package:chocsarayi/screens/order/order_details_screen.dart';
import 'package:chocsarayi/screens/order/widget/order_shimmer.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';


class OrderView extends StatefulWidget{
  final bool isRunning;
  OrderView({@required this.isRunning});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _OrderView(isRunning: isRunning);
  }

}


class _OrderView extends State<OrderView> {
  final bool isRunning;
  _OrderView({@required this.isRunning}){
    if(user!=null) {
      getmyorders(user['userid']).then((value) {
        List<OrderModel> orderList2 = [];
        for (var o in value) {
          List pr = o['products'].toString().split("*");
          OrderModel order = new OrderModel(
              id: o['id'],
              userId: int.parse(o['user_id'].toString()),
              orderStatus: o['status'],
              orderAmount: o['amount'],
              deliveryAddressId: int.parse(o['address_id'].toString()),
              createdAt: o['created_at'],
              updatedAt: o['updated_at'],
              orderNote: o['note'],
              count: (pr.length - 1).toString()
          );

          if (isRunning) {
            if (order.orderStatus == "new" ) {
              orderList2.add(order);
            }
          }
          else {
            if (order.orderStatus == "reject" ||
                order.orderStatus == "completed"|| order.orderStatus == "accept" ||
                order.orderStatus == "delivery") {
              orderList2.add(order);
            }
          }
        }
        setState(() {
          orderList = orderList2;
        });
      });
    }
  }
  List<OrderModel> orderList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Directionality(
        textDirection: TextDirection.rtl,
        child: _build(context),
      ),
    );
  }

  Widget _build(BuildContext context){




        return orderList != null ? orderList.length > 0 ? RefreshIndicator(
          onRefresh: () async {

          },
          backgroundColor: Theme.of(context).primaryColor,
          child: ListView.builder(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            itemCount: orderList.length,
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  boxShadow: [BoxShadow(
                    color: Colors.grey.shade700,
                    spreadRadius: 1, blurRadius: 5,
                  )],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(children: [

                  Row(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        Images.placeholder_image,
                        height: 70, width: 80, fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Row(children: [
                          Text('رقم الطلب :', style: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
                          SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          Text(orderList[index].id.toString(), style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
                          SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                        ]),
                        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        Text(
                          ' العناصر : '+orderList[index].count,
                          style: rubikRegular.copyWith(color: ColorResources.COLOR_GREY),
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        Row(children: [
                          Icon(Icons.check_circle, color: ColorResources.COLOR_PRIMARY, size: 15),
                          SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          Text(
              orderList[index].orderStatus=="new"?"طلب جديد":orderList[index].orderStatus=="accept"?"تم قبول الطلب":orderList[index].orderStatus=="reject"?"تم رفض الطلب":orderList[index].orderStatus
                            ,
                            style: rubikRegular.copyWith(color:
                            orderList[index].orderStatus=="new"?ColorResources.COLOR_PRIMARY:orderList[index].orderStatus=="accept"?Colors.green:orderList[index].orderStatus=="reject"?Colors.red:ColorResources.COLOR_PRIMARY
                            ),
                          ),
                        ]),
                      ]),
                    ),
                  ]),
                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                  SizedBox(
                    height: 50,
                    child: Row(children: [
                      Expanded(child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: BorderSide(width: 2, color: Theme.of(context).primaryColor)),
                          padding: EdgeInsets.all(10),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => OrderDetailsScreen(
                            orderModel: orderList[index], orderId: orderList[index].id,
                          )));
                        },
                        child: Text('التفاصيل', style: Theme.of(context).textTheme.headline3.copyWith(
                          color: ColorResources.DISABLE_COLOR,
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                        )),
                      )),

                      // Expanded(child: !isRunning?CustomButton(
                      //   btnTxt: 'اعادة الطلب',
                      //   onTap: () async {
                      //
                      //   },
                      // ):SizedBox()
                      // ),
                    ]),
                  ),

                ]),
              );
            },
          ),
        ) : NoDataScreen(isOrder: true) : OrderShimmer();
  }
}
