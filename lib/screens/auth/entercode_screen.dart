import 'package:chocsarayi/api/login.dart';
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

class EntercodeScreen extends StatefulWidget {

  String verificationId;
  String email;
  String password;
  String dob;
  EntercodeScreen(this.verificationId,this.email,this.password,this.dob);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<EntercodeScreen> {

  final _codeController = TextEditingController();

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {

    super.dispose();
  }



  bool load=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
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
                'الرجاء ادخال كود التحقق',
                style: Theme.of(context).textTheme.headline2.copyWith(color: ColorResources.getHintColor(context)),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              CustomTextField(
                hintText: '00000000',
                isShowBorder: true,
                controller: _codeController,
              ),

              // for login button
              SizedBox(height: 10),
              CustomButton(
                btnTxt: 'تحقق',
                onTap: () async {
                  FirebaseAuth _auth = FirebaseAuth.instance;
                  final code = _codeController.text.trim();
                  AuthCredential credential = PhoneAuthProvider.credential(verificationId: widget.verificationId, smsCode: code);

                  _auth.signInWithCredential(credential).onError((error, stackTrace) {
                    print("wrong code");
                  }).then((value) {
                    if(value!=null) {
                      print('success');
                      douserlogin(widget.email,widget.password,widget.dob,context);
                    }
                    else{
                      print("wrong code2");
                    }
                  });
                },
              ),

              // for create an account
              SizedBox(height: 20),
            ],
          ),
        ),
        if(load)
          loading()
      ],)
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
