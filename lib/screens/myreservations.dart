import 'package:chocsarayi/api/getdata.dart';
import 'package:chocsarayi/data/model/response/address_model.dart';
import 'package:flutter/material.dart';
import 'package:chocsarayi/utill/dimensions.dart';
import 'package:chocsarayi/base/custom_app_bar.dart';
import 'package:chocsarayi/base/no_data_screen.dart';
import 'package:chocsarayi/screens/address/widget/address_widget.dart';
import 'package:provider/provider.dart';

import '../main.dart';



class MyReservationsScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ads();
  }

}

class reservation{
  String time;
  String date;
  String number;
  String status;
  reservation(this.time,this.date,this.number,this.status);
}

class ads extends State<MyReservationsScreen> {


  ads(){
    List <reservation>myreses2=[];
    getmyreservations(user['userid']).then((value) {
     for(var i in value){
       String status="";
       if(i['status']=="new"){
         status="جديد";
       }
       else if(i['status']=="approve"){
         status="تم الحجز";
       }
       else if(i['status']=="cancel"){
         status="تم الالغاء";
       }
       reservation r = new reservation(i['res_time'], i['res_date'], i['numofpeople'], status);
       myreses2.add(r);
     }
     setState(() {
       myreses=myreses2;
     });

    });
  }

  List <reservation>myreses;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(title: 'الحجوزات السابقة'),
      body:  myreses != null ? myreses.length > 0 ?  ListView.builder(
    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
    itemCount: myreses.length,
    itemBuilder: (context, index) {
      return Container(
        height: 101,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border:Border.all(color: Colors.grey,width: 0.2)
        ),
        child: Column(
          children: [
            Container(height: 40,
            child: Row(
              children: [
              Text("التاريخ : "+myreses[index].date),
              Spacer(),
              Text("الوقت : "+myreses[index].time),
            ],),
            ),
            Container(height: 40,
              child: Row(

                children: [
                Text("العدد : "+myreses[index].number),
                Spacer(),
                Text("الحالة : "+myreses[index].status),
              ],),
            )
          ],
        ),
      );
    }
    )
    : NoDataScreen()
        : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)))
    );
  }
}
