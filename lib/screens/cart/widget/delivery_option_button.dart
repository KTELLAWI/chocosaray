import 'package:flutter/material.dart';
import 'package:chocsarayi/helper/price_converter.dart';
import 'package:chocsarayi/utill/dimensions.dart';
import 'package:chocsarayi/utill/styles.dart';
import 'package:provider/provider.dart';

class DeliveryOptionButton extends StatelessWidget {
  final String value;
  final String title;
  DeliveryOptionButton({@required this.value, @required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () => order.setOrderType(value),
      child: Row(
        children: [

          SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

          Text(title, style: rubikRegular),
          SizedBox(width: 5),

          Text( 'free', style: rubikMedium),

        ],
      ),
    );
  }
}
