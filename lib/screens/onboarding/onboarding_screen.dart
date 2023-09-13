import 'package:chocsarayi/screens/auth/login_screen.dart';
import 'package:chocsarayi/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:chocsarayi/utill/color_resources.dart';
import 'package:chocsarayi/utill/dimensions.dart';
import 'package:chocsarayi/base/custom_button.dart';
import 'package:chocsarayi/screens/welcome_screen/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../onboarding_provider.dart';

class OnBoardingScreen extends StatelessWidget {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    Provider.of<OnBoardingProvider>(context, listen: false).initBoardingList(context);

    return Scaffold(
      body: Consumer<OnBoardingProvider>(
        builder: (context, onBoardingList, child) => onBoardingList.onBoardingList.length > 0 ? SafeArea(
          child: ListView(
            children: [

              onBoardingList.selectedIndex != onBoardingList.onBoardingList.length-1 ? Align(
                alignment: Alignment.topRight,
                child: TextButton(
                    onPressed: ()async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setString("first", "no");
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => DashboardScreen()));                    },
                    child: Text(
                      'تخطي',
                      style: Theme.of(context).textTheme.headline3.copyWith(color: Theme.of(context).textTheme.bodyText1.color),
                    )),
              ) : SizedBox(),

              SizedBox(
                height: 400,
                child: PageView.builder(
                  itemCount: onBoardingList.onBoardingList.length,
                  controller: _pageController,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(30),
                      child: Image.asset(onBoardingList.onBoardingList[index].imageUrl),
                    );
                  },
                  onPageChanged: (index) {
                    onBoardingList.changeSelectIndex(index);
                  },
                ),
              ),

              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _pageIndicators(onBoardingList.onBoardingList, context),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60, right: 60, top: 50, bottom: 22),
                    child: Text(
                      onBoardingList.selectedIndex == 0
                          ? onBoardingList.onBoardingList[0].title
                          : onBoardingList.selectedIndex == 1
                              ? onBoardingList.onBoardingList[1].title
                              : onBoardingList.onBoardingList[2].title,
                      style: Theme.of(context).textTheme.headline3.copyWith(fontSize: 24.0, color: Theme.of(context).textTheme.bodyText1.color),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
                    child: Text(
                      onBoardingList.selectedIndex == 0
                          ? onBoardingList.onBoardingList[0].description
                          : onBoardingList.selectedIndex == 1
                              ? onBoardingList.onBoardingList[1].description
                              : onBoardingList.onBoardingList[2].description,
                      style: Theme.of(context).textTheme.headline2.copyWith(
                            fontSize: Dimensions.FONT_SIZE_LARGE,
                            color: ColorResources.getGrayColor(context),
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(onBoardingList.selectedIndex == 2 ? 0 : 22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        onBoardingList.selectedIndex == 0 || onBoardingList.selectedIndex == 2
                            ? SizedBox.shrink()
                            : TextButton(
                                onPressed: () {
                                  _pageController.previousPage(duration: Duration(seconds: 1), curve: Curves.ease);
                                },
                                child: Text(
                                  'السابق',
                                  style: Theme.of(context).textTheme.headline3.copyWith(color: ColorResources.getGrayColor(context)),
                                )),
                        onBoardingList.selectedIndex == 2
                            ? SizedBox.shrink()
                            : TextButton(
                                onPressed: () {
                                  _pageController.nextPage(duration: Duration(seconds: 1), curve: Curves.ease);
                                },
                                child: Text(
                                  'التالي',
                                  style: Theme.of(context).textTheme.headline3.copyWith(color: ColorResources.getGrayColor(context)),
                                )),
                      ],
                    ),
                  ),
                  onBoardingList.selectedIndex == 2
                      ? Padding(
                          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                          child: CustomButton(
                            btnTxt: 'البدء',
                            onTap: () async{
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.setString("first", "no");
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => DashboardScreen()));
                            },
                          ))
                      : SizedBox.shrink()
                ],
              ),
            ],
          ),
        ) : SizedBox(),
      ),
    );
  }

  List<Widget> _pageIndicators(var onBoardingList, BuildContext context) {
    List<Container> _indicators = [];

    for (int i = 0; i < onBoardingList.length; i++) {
      _indicators.add(
        Container(
          width: i == Provider.of<OnBoardingProvider>(context).selectedIndex ? 16 : 7,
          height: 7,
          margin: EdgeInsets.only(right: 5),
          decoration: BoxDecoration(
            color: i == Provider.of<OnBoardingProvider>(context).selectedIndex ? Theme.of(context).primaryColor : ColorResources.getGrayColor(context),
            borderRadius: i == Provider.of<OnBoardingProvider>(context).selectedIndex ? BorderRadius.circular(50) : BorderRadius.circular(25),
          ),
        ),
      );
    }
    return _indicators;
  }
}
