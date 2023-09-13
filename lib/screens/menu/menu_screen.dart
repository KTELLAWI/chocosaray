import 'package:chocsarayi/api/deletemyaccount.dart';
import 'package:chocsarayi/screens/address/address_screen.dart';
import 'package:chocsarayi/screens/auth/login_screen.dart';
import 'package:chocsarayi/screens/menu/widget/sign_out_confirmation_dialog.dart';
import 'package:chocsarayi/screens/ourbranches.dart';
import 'package:chocsarayi/screens/pointsscreen.dart';
import 'package:chocsarayi/screens/reservation.dart';
import 'package:chocsarayi/screens/walletscreen.dart';
import 'package:flutter/material.dart';
import 'package:chocsarayi/theme_provider.dart';
import 'package:chocsarayi/utill/color_resources.dart';
import 'package:chocsarayi/utill/dimensions.dart';
import 'package:chocsarayi/utill/images.dart';
import 'package:chocsarayi/utill/styles.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';
class MenuScreen extends StatelessWidget {
  final Function onTap;
  MenuScreen({@required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, child:
    Scaffold(
      body: Column(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 50),
          decoration: BoxDecoration(color: Colors.grey.shade300),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              height: 80, width: 120,
              child: ClipOval(
                child: Image.asset(
                  Images.logo,
                  height: 80, width: 120, fit: BoxFit.contain,
                ),
              ),
            ),
            if(user!=null)
            Shimmer.fromColors(
              baseColor: Colors.black87,
              highlightColor: Colors.black12,
              enabled: true,
              child: Column(children: [
                Text(
                  'أهلا بك',
                  style: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE, color: Colors.black),
                ) ,
                SizedBox(height: 10),
                Text(
                  user['name'],
                  style: rubikRegular.copyWith(color:Colors.black),
                )
              ]),
            )
          ]),
        ),
        Expanded(
          child: ListView(padding: EdgeInsets.zero, physics: BouncingScrollPhysics(), children: [
            if(user!=null)
            ListTile(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => WalletScreen())),
              leading: Image.asset("assets/icon/wallet.png", width: 20, height: 20, color: Theme.of(context).textTheme.bodyText1.color),
              title: Text('محفظتي', style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
            ),
            if(user!=null)
              ListTile(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PointsScreen())),
                leading: Image.asset("assets/icon/gift.png", width: 20, height: 20, color: Theme.of(context).textTheme.bodyText1.color),
                title: Text('النقاط والجوائز', style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
              ),
            if(user!=null)
            ListTile(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AddressScreen())),
              leading: Image.asset(Images.location, width: 20, height: 20, color: Theme.of(context).textTheme.bodyText1.color),
              title: Text('قائمة العناوين', style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
            ),
            if(user!=null)
              ListTile(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => reservationScreen())),
                leading: Image.asset("assets/icon/table.png", width: 20, height: 20, color: Theme.of(context).textTheme.bodyText1.color),
                title: Text('حجز طاولة', style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
              ),
            if(user!=null)
              ListTile(
                // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => reservationScreen())),
                leading: Image.asset(Images.location, width: 20, height: 20, color: Theme.of(context).textTheme.bodyText1.color),
                title: Text('تغيير المدينة', style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
              ),
            if(user==null)
              ListTile(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen())),
                leading: Icon(Icons.login, size: 20, color: Theme.of(context).textTheme.bodyText1.color),
                title: Text('تسجيل الدخول', style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
              ),
            ListTile(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OurBranchesScreen())),
              leading: Icon(Icons.location_city, size: 20, color: Theme.of(context).textTheme.bodyText1.color),
              title: Text('فروعنا', style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
            ),
            ListTile(
              // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SupportScreen())),
              onTap: ()async {
                String _url="https://chocolatesarayi.xyz/public/files/help.html";
                await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
              },
              leading: Icon(Icons.contact_support, size: 20, color: Theme.of(context).textTheme.bodyText1.color),
              title: Text('المساعدة والدعم', style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
            ),
            ListTile(
              onTap: ()async {
                String _url="https://chocolatesarayi.xyz/public/files/pp.html";
                await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
              },
              leading: Icon(Icons.rule, size: 20, color: Theme.of(context).textTheme.bodyText1.color),
              title: Text('الشروط والأحكام', style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
            ),
            if(user!=null)
              ListTile(
                onTap: () {
                  dodeletemyaccount(context);
                },
                leading: Image.asset(Images.log_out, width: 20, height: 20, color: Theme.of(context).textTheme.bodyText1.color),
                title: Text('حذف الحساب', style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
              ),
            if(user!=null)
            ListTile(
              onTap: () {
                showDialog(context: context, builder: (_) => SignOutConfirmationDialog());
              },
              leading: Image.asset(Images.log_out, width: 20, height: 20, color: Theme.of(context).textTheme.bodyText1.color),
              title: Text('تسجيل خروج', style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
            ),
          ]),
        ),
      ]),
    )
    );
  }
}
