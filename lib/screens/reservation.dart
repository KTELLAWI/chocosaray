import 'package:chocsarayi/api/sendreservation.dart';
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

class reservationScreen extends StatefulWidget {
  @override
  _reservationScreenState createState() => _reservationScreenState();
}

class _reservationScreenState extends State<reservationScreen> {

  FocusNode _dateFocus = FocusNode();
  FocusNode _timeFocus = FocusNode();
  FocusNode _numberFocus = FocusNode();
  FocusNode _noteFocus = FocusNode();
  TextEditingController _dateController;
  TextEditingController _timeController;
  TextEditingController _numberController;
  TextEditingController _noteController;
  GlobalKey<FormState> _formKeyLogin;
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _selectedKind;
  List _kinds = ["عيد ميلاد", "خطوبة", "زواج", "تخرج", "مولود جديد","آخر"];
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
    _dateController = TextEditingController();
    _timeController = TextEditingController();
    _numberController = TextEditingController();
    _noteController = TextEditingController();


  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _numberController.dispose();
    _noteController.dispose();
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
                          Container(
                              height: 50, width: 100,
                              decoration: BoxDecoration( border: Border.all(color: ColorResources.COLOR_PRIMARY, width: 2)),
                              child:InkWell(child:Center(child: Text("حجوزاتي"),)
                                ,onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => MyReservationsScreen()));
                                },)
                          ),


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
              Text(
                'التاريخ',
                style: Theme.of(context).textTheme.headline2.copyWith(color: ColorResources.getHintColor(context)),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              GestureDetector(child:CustomTextField(
                isShowBorder: true,
                isEnabled: false,
                controller: _dateController,
              ),
              onTap: (){
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(2020, 6, 1),
                    maxTime: DateTime(2030, 12, 30), onChanged: (date) {
                      print('change $date');
                      year=date.year;
                      month=date.month;
                      day=date.day;

                      _dateController.text=date.year.toString()+"/"+date.month.toString()+"/"+date.day.toString();
                    }, onConfirm: (date) {
                      print('confirm $date');
                      year=date.year;
                      month=date.month;
                      day=date.day;
                      _dateController.text=date.year.toString()+"/"+date.month.toString()+"/"+date.day.toString();
                    }, currentTime: DateTime.now());
              },
              ),
              SizedBox(height: 20),
              Text(
                'الوقت',
                style: Theme.of(context).textTheme.headline2.copyWith(color: ColorResources.getHintColor(context)),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              GestureDetector(child:CustomTextField(
                isShowBorder: true,
                isEnabled: false,
                controller: _timeController,
              ),
              onTap: (){
                DatePicker.showTimePicker(context, showTitleActions: true,
                    onChanged: (date) {
                      print('change $date in time zone ' +
                          date.timeZoneOffset.inHours.toString());
                      hour=date.hour;
                      minute=date.minute;


                      _timeController.text=date.hour.toString()+":"+date.minute.toString();
                    }, onConfirm: (date) {
                      print('confirm $date');
                      hour=date.hour;
                      minute=date.minute;
                      _timeController.text=date.hour.toString()+":"+date.minute.toString();
                    }, currentTime: DateTime.now());
              },
              ),
              SizedBox(height: 20),
              Text(
                'عدد الأشخاص',
                style: Theme.of(context).textTheme.headline2.copyWith(color: ColorResources.getHintColor(context)),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              CustomTextField(
                isShowBorder: true,
                inputType: TextInputType.number,
                controller: _numberController,
              ),
              SizedBox(height: 20),
              Text(
                'نوع الطاولة',
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
                'ملاحظات',
                style: Theme.of(context).textTheme.headline2.copyWith(color: ColorResources.getHintColor(context)),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              CustomTextField(
                isShowBorder: true,
                maxLines: 3,
                controller: _noteController,
              ),

              // for login button
              SizedBox(height: 25),
              CustomButton(
                btnTxt: 'ارسال الحجز',
                onTap: () async {
                  String _date = _dateController.text.trim();
                  String _time = _timeController.text.trim();
                  String _number = _numberController.text.trim();
                  String _note = _noteController.text.trim();

                    if (_date.isEmpty) {
                      showCustomSnackBar('الرجاء ادخال التاريخ', context);
                    }
                    else if (_time.isEmpty) {
                      showCustomSnackBar('الرجاء ادخال الوقت', context);
                    }
                    else if (_number.isEmpty) {
                      showCustomSnackBar('الرجاء ادخال عدد الأشخاص', context);
                    }
                    else {
                      final date = DateTime(year,month,day,hour,minute);
                      final date2 = DateTime.now();
                      final difference = date.difference(date2).inHours;
                      print(difference);
                      if (difference<24) {
                        Fluttertoast.showToast(
                            msg: "لا يمكن الحجز قبل 24 ساعة",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: ColorResources.COLOR_PRIMARY,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                      else {
                        if (_note.isEmpty) {
                          dosendreservation(
                              _date, _time, "no", _number, _selectedKind,
                              context);
                        }
                        else {
                          dosendreservation(
                              _date, _time, _note, _number, _selectedKind,
                              context);
                        }
                      }
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
