import 'package:chocsarayi/api/getdata.dart';
import 'package:chocsarayi/api/switchpoints.dart';
import 'package:chocsarayi/base/custom_button.dart';
import 'package:chocsarayi/screens/address/address_screen.dart';
import 'package:chocsarayi/screens/auth/login_screen.dart';
import 'package:chocsarayi/screens/menu/widget/sign_out_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:chocsarayi/theme_provider.dart';
import 'package:chocsarayi/utill/color_resources.dart';
import 'package:chocsarayi/utill/dimensions.dart';
import 'package:chocsarayi/utill/images.dart';
import 'package:chocsarayi/utill/styles.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../main.dart';


class PointsScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PointsScreen();
  }

}

class _PointsScreen extends State<PointsScreen> {
  int amount=0;
  _PointsScreen(){
    getmypoints(user['userid']).then((value) {
      setState(() {
        amount=int.parse(value['amount']);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, child:
    Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 50,horizontal: 20),
          decoration: BoxDecoration(color: Colors.white),
          child: Column(mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
            Container(
              height: 50, width: 50,
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: ColorResources.COLOR_PRIMARY, width: 2)),
              child:IconButton(icon: Icon(Icons.arrow_forward_outlined,size: 26,color: ColorResources.COLOR_PRIMARY,),onPressed: (){
                Navigator.pop(context);
              },)
            ),


          ]),
        ),
        Expanded(child:
        Column(children: [
          Container(
            height: 150,
            child: Center(
              child: Container(
                height: 130,
                width: 130,
                child: Image.asset("assets/icon/gift.png",color: ColorResources.COLOR_PRIMARY,),
              ),
            ),
          ),
          SizedBox(height: 20,),
          Container(
            child: Center(
              child: Container(
                child: Text(amount.toString(),style: TextStyle(fontSize: 40,color: Colors.black,fontWeight: FontWeight.bold),),
              ),
            ),
          ),
          SizedBox(height: 5,),
          Container(
            child: Center(
              child: Container(
                child: Text("نقطة",style: TextStyle(fontSize: 20,color: Colors.black),),
              ),
            ),
          ),
          SizedBox(height: 40,),
  Container(
    padding: EdgeInsets.only(left: 20,right: 20),
    child:
    CustomButton(
      btnTxt: 'تحويل النقاط الى المحفظة',
      onTap: () async {
         if(amount<4000){
           Fluttertoast.showToast(
               msg: "الحد الادنى للتحويل هو 4000 نقطة",
               toastLength: Toast.LENGTH_SHORT,
               gravity: ToastGravity.CENTER,
               timeInSecForIosWeb: 1,
               backgroundColor: Colors.grey,
               textColor: Colors.white,
               fontSize: 16.0
           );
         }
         else{
            doswitchpoints(amount.toString(), context);
         }
      },
    ),
  )

        ],)
        )
      ]),
    )
    );
  }
}
