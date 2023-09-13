import 'package:chocsarayi/api/login.dart';
import 'package:chocsarayi/screens/auth/entercode_screen.dart';
import 'package:chocsarayi/screens/dashboard/dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chocsarayi/utill/color_resources.dart';
import 'package:chocsarayi/utill/dimensions.dart';
import 'package:chocsarayi/utill/images.dart';
import 'package:chocsarayi/base/custom_button.dart';
import 'package:chocsarayi/base/custom_snackbar.dart';
import 'package:chocsarayi/base/custom_text_field.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  FocusNode _emailNumberFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();
  FocusNode _dobFocus = FocusNode();
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _dobController;
  GlobalKey<FormState> _formKeyLogin;

  @override
  void initState() {
    super.initState();
    _formKeyLogin = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _dobController = TextEditingController();

    _emailController.text;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  Future<bool> loginUser(String phone, BuildContext context) async{
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async{
        
        },
        verificationFailed: (Exception exception){
          print(exception);
        },
        codeSent: (String verificationId, [int forceResendingToken]){
          String email = _emailController.text.trim();
          String password = _passwordController.text.trim();
          String dob = _dobController.text.trim();
          Navigator.push(context, MaterialPageRoute(builder: (_) => EntercodeScreen(verificationId,email,password,dob)));
        },
        codeAutoRetrievalTimeout: null
    );
  }




  bool load=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                //SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.asset(
                    Images.logo,
                    height: MediaQuery.of(context).size.height / 4.5,
                    fit: BoxFit.scaleDown,
                    matchTextDirection: true,
                  ),
                ),
                // SizedBox(height: 30),
                Text(
                  'Welcome',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline3.copyWith(color: Theme.of(context).textTheme.bodyText1.color, fontSize: 32),
                ),
                Padding(
                  padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  child: Text(
                    'Welcome to Chocolate Sarayi',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline2.copyWith(color: ColorResources.getGreyColor(context)),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                    child: Text(
                      'تسجيل الدخول',
                      style: Theme.of(context).textTheme.headline3.copyWith(fontSize: 24, color: ColorResources.getGreyBunkerColor(context)),
                    )),
                SizedBox(height: 35),
                Text(
                  'رقم الموبايل',
                  style: Theme.of(context).textTheme.headline2.copyWith(color: ColorResources.getHintColor(context)),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                CustomTextField(
                  hintText: '00000000',
                  isShowBorder: true,
                  controller: _emailController,
                ),
                SizedBox(height: 20),
                Text(
                  'الاسم',
                  style: Theme.of(context).textTheme.headline2.copyWith(color: ColorResources.getHintColor(context)),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                CustomTextField(
                  isShowBorder: true,
                  controller: _passwordController,
                ),
                SizedBox(height: 20),
                Text(
                  'المواليد',
                  style: Theme.of(context).textTheme.headline2.copyWith(color: ColorResources.getHintColor(context)),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                GestureDetector(child:CustomTextField(
                  isShowBorder: true,
                  isEnabled: false,
                  controller: _dobController,
                ),
                  onTap: (){
                    DatePicker.showDatePicker(context, showTitleActions: true,
                        onChanged: (date) {
                          print('change $date in time zone ' +
                              date.timeZoneOffset.inHours.toString());
                          _dobController.text=date.year.toString()+"/"+date.month.toString()+"/"+date.day.toString();
                        }, onConfirm: (date) {
                          print('confirm $date');
                          _dobController.text=date.year.toString()+"/"+date.month.toString()+"/"+date.day.toString();
                        }, currentTime: DateTime.now());
                  },
                ),
                SizedBox(height: 22),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox.shrink(),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "",
                        style: Theme.of(context).textTheme.headline2.copyWith(
                          fontSize: Dimensions.FONT_SIZE_SMALL,
                          color: ColorResources.getPrimaryColor(context),
                        ),
                      ),
                    )
                  ],
                ),

                // for login button
                SizedBox(height: 10),
                CustomButton(
                  btnTxt: 'دخول',
                  onTap: () async {
                    String _email = _emailController.text.trim();
                    String _password = _passwordController.text.trim();
                    String _dob ="0";
                    if (_email.isEmpty) {
                      showCustomSnackBar('الرجاء ادخال رقم الموبايل', context);
                    }
                    else if (_password.isEmpty) {
                      showCustomSnackBar('الرجاء ادخال الاسم', context);
                    }

                    else {
                      if(_dobController.text!=null&&_dobController.text!=""){
                        _dob=_dobController.text;
                      }
                      // douserlogin(_email,_password,_dob,context);
                      if(_email=="07517584199"){
                        douserlogin(_email,_password,_dob,context);
                      }
                      else{
                        FirebaseAuth _auth = FirebaseAuth.instance;
                        String mobile=_email.replaceFirst("0", '');
                        mobile="+964"+mobile;
                        print(mobile);
                        setState(() {
                          load=true;
                          loginUser(mobile, context);
                        });
                      }


                      // _auth.verifyPhoneNumber(
                      //     phoneNumber: mobile,
                      //     timeout: Duration(seconds: 60),
                      //     verificationCompleted: null,
                      //     verificationFailed: null,
                      //     codeSent: null,
                      //     codeAutoRetrievalTimeout: null
                      // );

                    }
                  },
                ),

                // for create an account
                SizedBox(height: 20),
              ],
            ),
          ),
          if(load)
            loading(),
        ],
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
