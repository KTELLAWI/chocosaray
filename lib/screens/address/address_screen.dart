import 'package:chocsarayi/api/getdata.dart';
import 'package:chocsarayi/data/model/response/address_model.dart';
import 'package:flutter/material.dart';
import 'package:chocsarayi/utill/dimensions.dart';
import 'package:chocsarayi/base/custom_app_bar.dart';
import 'package:chocsarayi/base/no_data_screen.dart';
import 'package:chocsarayi/screens/address/widget/address_widget.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import 'add_new_address_screen.dart';

class AddressScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ads();
  }

}


class ads extends State<AddressScreen> {


  ads(){
    List <AddressModel>addressList2=[];
    getmyaddresses(user['userid']).then((value){
      for(var i in value){
        addressList2.add(new AddressModel(
          id: i['id'],
          addressType: i['type'],
          contactPersonName: i['name'],
          contactPersonNumber: i['phone'],
          address: i['address'],
          latitude: i['lat'],
          longitude: i['long'],
          createdAt: i['created_at'].toString(),
          updatedAt: i['updated_at'].toString(),
        ));
      }
      setState(() {
        addressList=addressList2;
      });
    });
  }

  List <AddressModel>addressList=[];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(title: 'العناوين'),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => MainAddNewAddressScreen())),
      ),
      body:  addressList != null ? addressList.length > 0 ?  ListView.builder(
    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
    itemCount: addressList.length,
    itemBuilder: (context, index) => AddressWidget(
    addressModel: addressList[index],
    index: index,
    ),
    )
    : NoDataScreen()
        : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)))
    );
  }
}
