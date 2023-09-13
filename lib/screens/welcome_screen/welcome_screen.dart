import 'package:chocsarayi/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:chocsarayi/utill/color_resources.dart';
import 'package:chocsarayi/utill/dimensions.dart';
import 'package:chocsarayi/utill/images.dart';
import 'package:chocsarayi/base/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 50),
          Container(alignment: Alignment.bottomCenter, padding: EdgeInsets.all(30), child: Image.asset(Images.logo, height: 200)),
          SizedBox(height: 30),
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
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: CustomButton(
              btnTxt: 'Login',
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
