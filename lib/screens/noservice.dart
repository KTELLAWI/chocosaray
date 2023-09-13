


import 'package:chocsarayi/base/custom_button.dart';
import 'package:chocsarayi/screens/supportarea.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class noservicepage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Scaffold(
        body: Center(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("عذرا الخدمة حاليا غير متاحة في مدينتك",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.only(left: 35,right: 35),
            child: CustomButton(
              btnTxt: 'تقديم طلب دعم المنطقة',
              onTap: () async {
                Navigator.push(context, MaterialPageRoute(builder: (_) => supportareaScreen()));
              },
            ),
          )
          ,],
          )
        ),
      )
      ;
  }

}