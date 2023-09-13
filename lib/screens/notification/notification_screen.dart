import 'package:flutter/material.dart';
import 'package:chocsarayi/helper/date_converter.dart';
import 'package:chocsarayi/utill/color_resources.dart';
import 'package:chocsarayi/utill/dimensions.dart';
import 'package:chocsarayi/base/custom_app_bar.dart';
import 'package:chocsarayi/base/no_data_screen.dart';
import 'package:chocsarayi/screens/notification/widget/notification_dialog.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {

  List notificationList=[];

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: CustomAppBar(title: 'الاشعارات'),
      body:
         notificationList != null ? notificationList.length > 0 ? ListView.builder(
                itemCount: notificationList.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  DateTime _originalDateTime = DateConverter.isoStringToLocalDate(notificationList[index].createdAt);
                  DateTime _convertedDate = DateTime(_originalDateTime.year, _originalDateTime.month, _originalDateTime.day);
                  bool _addTitle = false;
                  return InkWell(
                    onTap: () {
                      showDialog(context: context, builder: (BuildContext context) {
                        return NotificationDialog(notificationModel: notificationList[index]);
                      });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _addTitle ? Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 2),
                          child: Text(DateConverter.isoStringToLocalDateOnly(notificationList[index].createdAt)),
                        ) : SizedBox(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
                          decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        DateConverter.isoStringToLocalTimeOnly(notificationList[index].createdAt),
                                        style: Theme.of(context).textTheme.headline2,
                                      ),
                                      Container(
                                          width: 35,
                                          height: 18,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL), color: ColorResources.getSearchBg(context)),
                                          child: Text(
                                            DateConverter.isoStringToLocalAMPM(notificationList[index].createdAt),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2
                                                .copyWith(fontSize: 11, color: ColorResources.getGrayColor(context).withOpacity(.8)),
                                          )),
                                    ],
                                  ),
                                  SizedBox(width: 24.0),
                                  Text(
                                    notificationList[index].title,
                                    style: Theme.of(context).textTheme.headline2.copyWith(
                                      fontSize: Dimensions.FONT_SIZE_LARGE,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                ],
                              ),
                              SizedBox(height: 20),
                              Container(height: 1, color: ColorResources.COLOR_GREY.withOpacity(.2))
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                })
              : NoDataScreen()
              : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)))


    );
  }
}
