import 'package:chocsarayi/api/getdata.dart';
import 'package:chocsarayi/data/model/response/address_model.dart';
import 'package:flutter/material.dart';
import 'package:chocsarayi/utill/dimensions.dart';
import 'package:chocsarayi/base/custom_app_bar.dart';
import 'package:chocsarayi/base/no_data_screen.dart';
import 'package:chocsarayi/screens/address/widget/address_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';



class OurBranchesScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ads();
  }

}

class branch{
  String name;
  String prov;
  String address;
  String phone;
  String lat;
  String long;
  branch(this.name,this.prov,this.address,this.phone,this.lat,this.long);
}

class ads extends State<OurBranchesScreen> {


  ads(){
    List <branch>mybranchs2=[];
   getourbranches().then((value) {
    for(var i in value){
      branch b = new branch(i['name'], i['prov'], i['address'], i['phone'], i['lat'], i['long']);
      mybranchs2.add(b);
    }
    setState(() {
      mybranchs=mybranchs2;
    });
   });
  }

  List <branch>mybranchs;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(title: 'فروعنا'),
      body:  mybranchs != null ? mybranchs.length > 0 ? Directionality(textDirection: TextDirection.rtl, child:
      ListView.builder(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          itemCount: mybranchs.length,
          itemBuilder: (context, index) {
            return Container(
              height: 120,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border:Border.all(color: Colors.grey,width: 0.2)
              ),
              child: Column(
                children: [
                  Container(height: 30,
                    child: Row(
                      children: [
                        Text("الاسم : "+mybranchs[index].name),
                        Spacer(),
                        Text("المحافظة : "+mybranchs[index].prov),
                      ],),
                  ),
                  Container(height: 30,
                    child: Row(
                      children: [
                        Text("العنوان : "+mybranchs[index].address),
                        Spacer(),
                        IconButton(icon: Icon(Icons.map,color: Colors.green,), onPressed:()async{
                          String lat=mybranchs[index].lat;
                          String long=mybranchs[index].long;
                          String url = 'https://www.google.com/maps/search/?api=1&query=$lat,$long';
                          print(url);
                          if (await canLaunch(url)) {
                          await launch(url);
                          } else {
                          throw 'Could not launch $url';
                          }
                        })
                      ],),
                  ),
                  Container(height: 30,
                    child: Row(
                      children: [
                        Text("الهاتف : "+mybranchs[index].phone),
                        Spacer(),
                        IconButton(icon: Icon(Icons.call,color: Colors.blue,), onPressed:()async{
                          String phone=mybranchs[index].phone;
                          url = "tel:$phone";
                          print(url);
                          if (await canLaunch(url)) {
                          await launch(url);
                          } else {
                          throw 'Could not launch $url';
                          }
                        })
                      ],),
                  )
                ],
              ),
            );
          }
      )
      )
    : NoDataScreen()
        : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)))
    );
  }
}
