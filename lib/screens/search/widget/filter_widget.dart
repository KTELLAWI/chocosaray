// import 'package:flutter/material.dart';
// import 'package:chocsarayi/utill/color_resources.dart';
// import 'package:chocsarayi/utill/dimensions.dart';
// import 'package:chocsarayi/utill/styles.dart';
// import 'package:chocsarayi/base/custom_button.dart';
// import 'package:chocsarayi/screens/home/widget/category_view.dart';
// import 'package:provider/provider.dart';
//
//
// class FilterWidget extends StatefulWidget{
//   final double maxValue;
//   FilterWidget({@required this.maxValue});
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return _FilterWidget(maxValue: maxValue);
//   }
//
// }
//
//
//
// class _FilterWidget extends State<FilterWidget> {
//   final double maxValue;
//   _FilterWidget({@required this.maxValue});
//   double rating=0;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               IconButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 icon: Icon(Icons.close, size: 18, color: ColorResources.getGreyBunkerColor(context)),
//               ),
//               Align(
//                 alignment: Alignment.center,
//                 child: Text(
//                   'التصفية',
//                   textAlign: TextAlign.center,
//                   style: Theme.of(context).textTheme.headline3.copyWith(
//                     fontSize: Dimensions.FONT_SIZE_LARGE,
//                     color: ColorResources.getGreyBunkerColor(context),
//                   ),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {
//
//                 },
//                 child: Text(
//                   'تصفير',
//                   style: Theme.of(context).textTheme.headline2.copyWith(color: Theme.of(context).primaryColor),
//                 ),
//               )
//             ],
//           ),
//
//           Text(
//             'السعر',
//             style: Theme.of(context).textTheme.headline3,
//           ),
//
//           // price range
//           FlutterSlider(
//             values: [1,3],
//             rangeSlider: true,
//             max: maxValue,
//             min: 0,
//             trackBar: FlutterSliderTrackBar(
//               activeTrackBarHeight: 5,
//               activeTrackBar: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Theme.of(context).primaryColor),
//             ),
//             tooltip: FlutterSliderTooltip(
//               alwaysShowTooltip: false,
//               boxStyle: FlutterSliderTooltipBox(),
//               textStyle: TextStyle(fontSize: 14, color: Colors.lightBlue),
//             ),
//             handler: FlutterSliderHandler(
//               decoration: BoxDecoration(),
//               child: Container(
//                   width: 20,
//                   height: 20,
//                   decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(color: Theme.of(context).primaryColor, width: 3),
//                       color: Colors.white)),
//             ),
//             rightHandler: FlutterSliderHandler(
//               decoration: BoxDecoration(),
//               child: Container(
//                   width: 20,
//                   height: 20,
//                   decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(color: Theme.of(context).primaryColor, width: 3),
//                       color: Colors.white)),
//             ),
//             handlerWidth: 45,
//             handlerHeight: 40,
//             disabled: false,
//             onDragging: (handlerIndex, lowerValue, upperValue) {
//
//             },
//           ),
//
//           Text(
//             'التقييم',
//             style: Theme.of(context).textTheme.headline3,
//           ),
//
//           Center(
//             child: Container(
//               height: 30,
//               child: ListView.builder(
//                 itemCount: 5,
//                 shrinkWrap: true,
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (context, index) {
//                   return InkWell(
//                     child: Icon(
//                       rating < (index + 1) ? Icons.star_border : Icons.star,
//                       size: 20,
//                       color: rating < (index + 1) ? ColorResources.getGreyColor(context) : Theme.of(context).primaryColor,
//                     ),
//                     onTap: () {
//                      setState(() {
//                        rating=(index+1).toDouble();
//                      });
//                     },
//                   );
//                 },
//               ),
//             ),
//           ),
//
//           SizedBox(height: 30),
//
//           CustomButton(
//             btnTxt: 'تطبيق',
//             onTap: () {
//
//
//               Navigator.pop(context);
//             },
//           )
//         ],
//       ),
//     );
//   }
// }
