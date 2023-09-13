import 'package:chocsarayi/db/Database.dart';
import 'package:chocsarayi/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chocsarayi/utill/color_resources.dart';
import 'package:chocsarayi/utill/dimensions.dart';
import 'package:chocsarayi/utill/styles.dart';
import 'package:chocsarayi/screens/splash/splash_screen.dart';

import '../../../main.dart';

class SignOutConfirmationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [

        SizedBox(height: 20),
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.transparent,
          child: Icon(Icons.contact_support,color: ColorResources.COLOR_PRIMARY, size: 50),
        ),

        Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          child: Text('Do you want to sign out', style: rubikBold, textAlign: TextAlign.center),
        ),

        Divider(height: 0, color: ColorResources.getHintColor(context)),
        Row(children: [

          Expanded(child: InkWell(
            onTap: () async{
              Navigator.pop(context);
              await DBProvider.db.deleteAll();
              user = await DBProvider.db.getClient(1);
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => DashboardScreen()), (route) => false);
            },
            child: Container(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              alignment: Alignment.center,
              decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10))),
              child: Text('yes', style: rubikBold.copyWith(color: ColorResources.COLOR_PRIMARY)),
            ),
          )),

          Expanded(child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              alignment: Alignment.center,
              decoration: BoxDecoration(color: ColorResources.getPrimaryColor(context), borderRadius: BorderRadius.only(bottomRight: Radius.circular(10))),
              child: Text('no',  style: rubikBold.copyWith(color: Colors.white)),
            ),
          )),

        ]),
      ]),
    );
  }
}
