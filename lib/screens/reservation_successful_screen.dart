import 'package:flutter/material.dart';
import 'package:chocsarayi/utill/color_resources.dart';
import 'package:chocsarayi/utill/dimensions.dart';
import 'package:chocsarayi/utill/styles.dart';
import 'package:chocsarayi/base/custom_button.dart';
import 'package:chocsarayi/screens/dashboard/dashboard_screen.dart';

class reservationSuccessfulScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [

          Container(
            height: 100, width: 100,
            decoration: BoxDecoration(
              color: ColorResources.getPrimaryColor(context).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle ,
              color: ColorResources.getPrimaryColor(context), size: 80,
            ),
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

          Text(
            'تم ارسال الطلب بنجاح',
            style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),
          ),
          Text(
            'سيتواصل معكم خدمة الزبائن لتأكيد الحجز',
            style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),
          ),

          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

          SizedBox(height: 30),

          Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
            child: CustomButton(btnTxt:  'متابعة' , onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardScreen()));
            }),
          ),

        ]),
      ),
    );
  }
}
