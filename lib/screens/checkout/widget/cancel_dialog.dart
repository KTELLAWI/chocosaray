import 'package:flutter/material.dart';
import 'package:chocsarayi/data/model/response/order_model.dart';
import 'package:chocsarayi/utill/color_resources.dart';
import 'package:chocsarayi/utill/dimensions.dart';
import 'package:chocsarayi/utill/styles.dart';
import 'package:chocsarayi/base/custom_button.dart';


class CancelDialog extends StatelessWidget {
  final OrderModel orderModel;
  final bool fromCheckout;
  CancelDialog({@required this.orderModel, @required this.fromCheckout});
  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
        child: Column(mainAxisSize: MainAxisSize.min, children: [

          Container(
            height: 70, width: 70,
            decoration: BoxDecoration(
              color: ColorResources.getPrimaryColor(context).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle,
              color: ColorResources.getPrimaryColor(context), size: 50,
            ),
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

          fromCheckout ? Text(
            'تم ارسال الطلب بنجاح',
            style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: Theme.of(context).primaryColor),
          ) : SizedBox(),
          SizedBox(height: fromCheckout ? Dimensions.PADDING_SIZE_SMALL : 0),

          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('رقم الطلب', style: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
            SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            Text(orderModel.id.toString(), style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)),
          ]),
          SizedBox(height: 30),

          Row(children: [
            SizedBox(width: 10),
            Expanded(child: CustomButton(btnTxt: 'Order Details', onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
              // Navigator.push(context, MaterialPageRoute(builder: (_) => OrderDetailsScreen(orderModel: orderModel, orderId: orderModel.id)));
            })),
          ]),

        ]),
      ),
    );
  }
}
