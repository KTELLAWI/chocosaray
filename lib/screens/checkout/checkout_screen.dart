import 'dart:collection';
import 'dart:typed_data';
import 'dart:ui';
import 'package:chocsarayi/api/sendorder.dart';
import 'package:chocsarayi/main.dart';
import 'package:chocsarayi/api/getdata.dart';
import 'package:chocsarayi/data/model/response/address_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chocsarayi/data/model/body/place_order_body.dart';
import 'package:chocsarayi/data/model/response/cart_model.dart';
import 'package:chocsarayi/data/model/response/config_model.dart';
import 'package:chocsarayi/utill/color_resources.dart';
import 'package:chocsarayi/utill/dimensions.dart';
import 'package:chocsarayi/utill/images.dart';
import 'package:chocsarayi/utill/styles.dart';
import 'package:chocsarayi/base/custom_app_bar.dart';
import 'package:chocsarayi/base/custom_button.dart';
import 'package:chocsarayi/base/custom_text_field.dart';
import 'package:chocsarayi/screens/address/add_new_address_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'order_successful_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final double amount;
  final String orderType;

  CheckoutScreen({ @required this.amount, @required this.orderType});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {

  bool load=false;
  _CheckoutScreenState(){
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
          selected: false
        ));

      }
      setState(() {
        addressList=addressList2;
      });
    });
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _noteController = TextEditingController();
  GoogleMapController _mapController;
  bool _isCashOnDeliveryActive;
  bool _isDigitalPaymentActive;
  List addressList = [];
  bool _loading = true;
  Set<Marker> _markers = HashSet<Marker>();

  @override
  void initState() {
    super.initState();
  }

  String addressid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(title:'متابعة الطلب'),
      body:Directionality(
        textDirection: TextDirection.rtl,
        child:  Stack(
          children: [
            Column(
              children: [
                Column(children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                    child: Row(children: [
                      Text('عنوان التوصيل', style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                      Expanded(child: SizedBox()),
                      TextButton.icon(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MainAddNewAddressScreen(fromCheckout: true,amount: widget.amount,))),
                        icon: Icon(Icons.add),
                        label: Text('أضف', style: rubikRegular),
                      ),
                    ]),
                  ),
                  SizedBox(height: 10,),
                  if(addressList.length!=0)
                    SizedBox(
                        height: 60,
                        child:  ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
                          itemCount: addressList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {


                                setState(() {
                                  addressid=addressList[index].id.toString();
                                  for(var a in addressList){
                                    a.selected=false;
                                  }
                                  addressList[index].selected=true;
                                });
                              },
                              child: Stack(children: [
                                Container(
                                  height: 60,
                                  width: 200,
                                  margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_LARGE),
                                  decoration: BoxDecoration(
                                    color:  Theme.of(context).accentColor ,
                                    borderRadius: BorderRadius.circular(10),
                                    border:  Border.all(color: ColorResources.getPrimaryColor(context), width: 2) ,
                                  ),
                                  child: Row(children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                      child: Icon(
                                        Icons.home_outlined
                                        ,
                                        color:ColorResources.getPrimaryColor(context)
                                        ,
                                        size: 30,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                                        Text(addressList[index].addressType, style: rubikRegular.copyWith(
                                          fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.getGreyBunkerColor(context),
                                        )),
                                        Text(addressList[index].address, style: rubikRegular, maxLines: 1, overflow: TextOverflow.ellipsis),
                                      ]),
                                    ),
                                    if(addressList[index].selected)
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Icon(Icons.check_circle, color: ColorResources.getPrimaryColor(context)),
                                      ) ,
                                  ]),
                                ),

                              ]),
                            );
                          },
                        )

                    ),
                  if(addressList.length==0)
                    Text('لا يوجد عناوين مضافة', style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),textAlign: TextAlign.center,),
                  Padding(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    child: CustomTextField(
                      controller: _noteController,
                      hintText: 'ملاحظات',
                      maxLines: 5,
                      inputType: TextInputType.multiline,
                      inputAction: TextInputAction.newline,
                      capitalization: TextCapitalization.sentences,
                    ),
                  ),

                ]),
                if(addressList.length==0)
                  Padding(
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      child: Builder(
                        builder: (context) => CustomButton(btnTxt:'أضف عنوان للمتابعة', onTap: () {

                        }),
                      )
                  ),
                if(addressList.length!=0)
                  Padding(
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      child: Builder(
                        builder: (context) => CustomButton(btnTxt:'تأكيد الطلب', onTap: () {
                          String products="";
                          for(var i in cartproducts){
                            String p=i.product.id.toString()+":"+i.quantity.toString()+":"+i.product.type+":";
                            for(var a in i.product.addson){
                              if(a['added'].toString()=="1"){
                                p=p+a['id'].toString()+"-";
                              }
                            }
                            String finalp="";
                            if(p.endsWith("-")) {
                              finalp = p.substring(0, p.length - 1);
                            }
                            else{
                              finalp=p;
                            }
                            products=products+"*"+finalp;
                          }
                          // String finalproducts=products.substring(0,products.length-1);
                          //  print(finalproducts);
                          String note;
                          if(_noteController.text==""||_noteController.text==null){
                            note="no";
                          }
                          else{
                            note=_noteController.text;
                          }
                          print(products);
                          if(addressid==null){
                            Fluttertoast.showToast(
                                msg: "الرجاء تحديد عنوان",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey.shade200,
                                textColor: Colors.black,
                                fontSize: 16.0
                            );
                          }
                          else {
                            setState(() {
                              load=true;
                              dosendorder(addressid, products, note, widget.amount
                                  .toString(), context);
                            });

                          }

                        }),
                      )
                  ),

              ],
            ),
            if(load)
              loading()
          ],
        )
      )
    );
  }



  Widget loading(){
    return
      new Container(
        child: new Stack(
          children: <Widget>[
            new Container(
              alignment: AlignmentDirectional.center,
              decoration: new BoxDecoration(
                color: Colors.white70,
              ),
              child: new Container(
                decoration: new BoxDecoration(
                    color: Colors.grey.withOpacity(0.4),
                    borderRadius: new BorderRadius.circular(10.0)
                ),
                width: 300.0,
                height: 200.0,
                alignment: AlignmentDirectional.center,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Center(
                      child: new SizedBox(
                        height: 50.0,
                        width: 50.0,
                        child: new CircularProgressIndicator(
                          value: null,
                          backgroundColor: Colors.brown,
                          strokeWidth: 7.0,
                        ),
                      ),
                    ),
                    new Container(
                      margin: const EdgeInsets.only(top: 25.0),
                      child: new Center(
                        child: new Text(
                          "Please wait...",
                          style: new TextStyle(
                              color: Colors.brown
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );


  }
}
