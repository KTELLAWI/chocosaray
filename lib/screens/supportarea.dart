import 'package:chocsarayi/api/sendreservation.dart';
import 'package:chocsarayi/api/sendsupprequest.dart';
import 'package:chocsarayi/screens/dashboard/dashboard_screen.dart';
import 'package:chocsarayi/screens/myreservations.dart';
import 'package:flutter/material.dart';
import 'package:chocsarayi/utill/color_resources.dart';
import 'package:chocsarayi/utill/dimensions.dart';
import 'package:chocsarayi/utill/images.dart';
import 'package:chocsarayi/base/custom_button.dart';
import 'package:chocsarayi/base/custom_snackbar.dart';
import 'package:chocsarayi/base/custom_text_field.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class supportareaScreen extends StatefulWidget {
  @override
  _reservationScreenState createState() => _reservationScreenState();
}

class _reservationScreenState extends State<supportareaScreen> {

  TextEditingController _areaController;
  TextEditingController _provController;
  GlobalKey<FormState> _formKeyLogin;
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _selectedKind;
  List _kinds = ["العراق"];
  int year;
  int month;
  int day;
  int hour;
  int minute;
  @override
  void initState() {
    super.initState();
    _dropDownMenuItems = buildAndGetDropDownMenuItems(_kinds);
    _selectedKind = _dropDownMenuItems[0].value;
    _formKeyLogin = GlobalKey<FormState>();
    _provController = TextEditingController();
    _areaController = TextEditingController();



  }

  @override
  void dispose() {

    super.dispose();
  }
  List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(List fruits) {
    List<DropdownMenuItem<String>> items = new List();
    for (String fruit in fruits) {
      items.add(new DropdownMenuItem(value: fruit, child: new Text(fruit)));
    }
    return items;
  }

  void changedDropDownItem(String selectedFruit) {
    setState(() {
      _selectedKind = selectedFruit;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              //SizedBox(height: 30),
              Container(
                child: Row(children: [
                  Container(
                    child: Column(mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [



                        ]),
                    padding: EdgeInsets.only(left: 15,right: 15),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.only(left: 15,right: 15),


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

                ],),
              ),
             Directionality(textDirection: TextDirection.ltr, child:
             Padding(
               padding: const EdgeInsets.all(5.0),
               child: Image.asset(
                 Images.logo,
                 height: MediaQuery.of(context).size.height / 7.0,
                 fit: BoxFit.scaleDown,
                 matchTextDirection: true,
               ),
             ),
             ),
              // SizedBox(height: 30),
              SizedBox(height: 20),
              Text(
                'الدولة',
                style: Theme.of(context).textTheme.headline2.copyWith(color: ColorResources.getHintColor(context)),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              Container(
                padding: EdgeInsets.only(left: 15,right: 15),
                child:  new DropdownButton(
                  value: _selectedKind,
                  items: _dropDownMenuItems,
                  onChanged: changedDropDownItem,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'المحافظة',
                style: Theme.of(context).textTheme.headline2.copyWith(color: ColorResources.getHintColor(context)),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              CustomTextField(
                isShowBorder: true,
                controller: _provController,
              ),
              SizedBox(height: 20),
              Text(
                'المنطقة',
                style: Theme.of(context).textTheme.headline2.copyWith(color: ColorResources.getHintColor(context)),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              CustomTextField(
                isShowBorder: true,
                controller: _areaController,
              ),
              // for login button
              SizedBox(height: 25),
              CustomButton(
                btnTxt: 'ارسال',
                onTap: () async {
                  if(_provController.text!=""&&_areaController.text!="") {
                    dosendsupprequest(
                        _provController.text, _areaController.text, context);
                  }
                  else{
                    Fluttertoast.showToast(
                        msg: "يرجى تعبئة كافة الحقول",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: ColorResources.COLOR_PRIMARY,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }
                },
              ),
              // for create an account
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
