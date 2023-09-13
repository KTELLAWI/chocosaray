import 'package:chocsarayi/api/addtofav.dart';
import 'package:chocsarayi/api/deletefromfav.dart';
import 'package:chocsarayi/db/db.dart';
import 'package:chocsarayi/main.dart';
import 'package:chocsarayi/screens/auth/login_screen.dart';
import 'package:chocsarayi/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:chocsarayi/data/model/response/cart_model.dart';
import 'package:chocsarayi/data/model/response/product_model.dart';
import 'package:chocsarayi/helper/date_converter.dart';
import 'package:chocsarayi/helper/price_converter.dart';
import 'package:chocsarayi/utill/color_resources.dart';
import 'package:chocsarayi/utill/dimensions.dart';
import 'package:chocsarayi/utill/styles.dart';
import 'package:chocsarayi/base/custom_button.dart';
import 'package:chocsarayi/base/rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../theme_provider.dart';
import 'fullimageitems.dart';


class CartBottomSheet extends StatefulWidget{
  final Product product;
  final bool fromSetMenu;
  final Function callback;
  final CartModel cart;
  final int cartIndex;
  bool isExistInCart=false;
  List choiceOptions=[];

  CartBottomSheet({@required this.product, this.fromSetMenu = false, this.callback, this.cart, this.cartIndex});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CartBottomSheet(product: product,fromSetMenu: fromSetMenu);
  }

}

class _CartBottomSheet extends State<CartBottomSheet>{


  final Product product;
  final bool fromSetMenu;
  final Function callback;
  final CartModel cart;
  final int cartIndex;
  bool isExistInCart=false;
  bool isFavorate=false;
  List choiceOptions=[];

  _CartBottomSheet({@required this.product, this.fromSetMenu , this.callback, this.cart, this.cartIndex}){
    isfavorate(product.id.toString()).then((value) {
      setState(() {
        isFavorate=value;
      });
    });
  }
  List addOns=[];
  int quantity=0;
  double totalp=0.0;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(var c in cartproducts){
      if(c.product.id==product.id){
        isExistInCart=true;
      }
    }

  }


  @override
  Widget build(BuildContext context) {
    bool fromCart = cart != null;
    return Directionality(textDirection: TextDirection.rtl, child: Container(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if(!fromSetMenu)
            Container(
              padding: EdgeInsets.only(left: 10,top: 5),
              alignment: Alignment.centerLeft,
              child: InkWell(
                child: Icon(isFavorate?Icons.favorite:Icons.favorite_border, color: Colors.grey, size: 23),
                onTap: (){
                 if(isFavorate){
                   dodeletefromfav(product.id.toString(), context);
                   removefavs(product.id.toString());
                   setState(() {
                     isFavorate=false;
                   });
                 }
                 else if(!isFavorate){
                   doaddtofav(product.id.toString(), context);
                   insertfavorate(product.category, product.description, product.id.toString(), product.name, product.price.toString(), product.image);
                   setState(() {
                     isFavorate=true;
                   });
                 }
                },
              ),
            ),
            //Product
            Row(children: [
              InkWell(child:ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  product.image,
                  width: 100, height: 100, fit: BoxFit.cover,
                ),
              ),onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_) => GalleryPhotoViewWrapperitem(galleryItems: [product.image],)));
              },),
              SizedBox(width: 10),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    product.name, maxLines: 2, overflow: TextOverflow.ellipsis,
                    style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.price.toString(),
                        style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),
                      ),

                    ],
                  ),
                ]),
              ),
            ]),
            SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

            // Quantity
            Row(children: [
              Text('الكمية',style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
              Expanded(child: SizedBox()),
              Container(
                decoration: BoxDecoration(color: ColorResources.getBackgroundColor(context), borderRadius: BorderRadius.circular(5)),
                child: Row(children: [
                  InkWell(
                    onTap: () {
                     setState(() {
                      if(quantity>0){
                        quantity--;
                        double addsamount=0.0;
                        for(int i =0 ;i<product.addson.length;i++){
                          if(product.addson[i]['added'].toString()=="1"){
                            addsamount=addsamount+(double.parse(product.addson[i]['price'].toString())*quantity);
                          }
                        }
                        totalp=(product.price*quantity)+addsamount;
                      }
                     });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      child: Icon(Icons.remove, size: 20),
                    ),
                  ),
                  Text(quantity.toString(), style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE)),
                  InkWell(
                    onTap: () {
                      setState(() {
                        quantity++;
                        double addsamount=0.0;
                        for(int i =0 ;i<product.addson.length;i++){
                          if(product.addson[i]['added'].toString()=="1"){
                            addsamount=addsamount+(double.parse(product.addson[i]['price'].toString())*quantity);
                          }
                        }
                        totalp=(product.price*quantity)+addsamount;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      child: Icon(Icons.add, size: 20),
                    ),
                  ),
                ]),
              ),
            ]),
            SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

            // Variation
            ListView.builder(
              shrinkWrap: true,
              itemCount: choiceOptions.length,
              itemBuilder: (context, index) {
                return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(choiceOptions[index].title, style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 10,
                      childAspectRatio: (1 / 0.25),
                    ),
                    shrinkWrap: true,
                    itemCount: choiceOptions[index].options.length,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () {

                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          decoration: BoxDecoration(
                              color:  ColorResources.BACKGROUND_COLOR ,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: ColorResources.BORDER_COLOR, width: 2)
                          ),
                          child: Text(
                            choiceOptions[index].options[i].trim(), maxLines: 1, overflow: TextOverflow.ellipsis,
                            style: rubikRegular.copyWith(
                                color:  ColorResources.COLOR_BLACK
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: index != choiceOptions.length-1 ? Dimensions.PADDING_SIZE_LARGE : 0),
                ]);
              },
            ),
            choiceOptions.length > 0 ? SizedBox(height: Dimensions.PADDING_SIZE_LARGE) : SizedBox(),

             Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('الوصف', style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              Text(product.description ?? '', style: rubikRegular),
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
            ]) ,

            // Addons
            product.addson!=null? product.addson.length > 0 ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('الاضافات', style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 10,
                  childAspectRatio: (1 / 1.1),
                ),
                shrinkWrap: true,
                itemCount: product.addson.length,
                itemBuilder: (context, index) {
                  print(product.addson[index]);
                  return InkWell(
                    onTap: () {

                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom:  2 ),
                      decoration: BoxDecoration(
                          color: product.addson[index]['added'].toString()=="1"?ColorResources.COLOR_PRIMARY:Colors.white ,
                          borderRadius: BorderRadius.circular(5),
                          border:  null ,
                          boxShadow:  [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context)
                              .darkTheme ? 700 : 300], blurRadius: 5, spreadRadius: 1)]
                      ),
                      child: Column(children: [
                        Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text(product.addson[index]['name'], maxLines: 1, overflow: TextOverflow.ellipsis, style: rubikMedium.copyWith(
                            color:  product.addson[index]['added'].toString()=="1"?ColorResources.COLOR_WHITE:ColorResources.COLOR_PRIMARY ,
                            fontSize: Dimensions.FONT_SIZE_SMALL,
                          )),
                          SizedBox(height: 10),
                          Text(
                            product.addson[index]['price'].toString(), maxLines: 1, overflow: TextOverflow.ellipsis,
                            style: rubikRegular.copyWith(color:  product.addson[index]['added'].toString()=="1"?ColorResources.COLOR_WHITE:ColorResources.COLOR_PRIMARY
                                , fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL),
                          ),
                        ])),
                        if(product.addson[index]['added'].toString()=="0")
                        Container(
                          height: 25,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Theme.of(context).accentColor),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    product.addson[index]['added']=1;
                                    double addsamount=0.0;
                                    for(int i =0 ;i<product.addson.length;i++){
                                      if(product.addson[i]['added'].toString()=="1"){
                                        addsamount=addsamount+(double.parse(product.addson[i]['price'].toString())*quantity);
                                      }
                                    }
                                    totalp=(product.price*quantity)+addsamount;
                                  });
                                },
                                child: Center(child: Icon(Icons.add, size: 15)),
                              ),
                            ),
                          ]),
                        ),
                        if(product.addson[index]['added'].toString()=="1")
                          Container(
                            height: 25,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Theme.of(context).accentColor),
                            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      product.addson[index]['added']=0;
                                      double addsamount=0.0;
                                      for(int i =0 ;i<product.addson.length;i++){
                                        if(product.addson[i]['added'].toString()=="1"){
                                          addsamount=addsamount+(double.parse(product.addson[i]['price'].toString())*quantity);
                                        }
                                      }
                                      totalp=(product.price*quantity)+addsamount;
                                    });
                                  },
                                  child: Center(child: Icon(Icons.remove, size: 15)),
                                ),
                              ),
                            ]),
                          )
                      ]),
                    ),
                  );
                },
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            ]) : SizedBox(): SizedBox(),

            Row(children: [
              Text('القيمة الاجمالية', style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
              SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              Text(totalp.toString(), style: rubikBold.copyWith(
                color: ColorResources.COLOR_PRIMARY, fontSize: Dimensions.FONT_SIZE_LARGE,
              )),
            ]),
            SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
            if(user!=null)
            CustomButton(
              btnTxt:  'أضف الى السلة',
              backgroundColor: quantity>0?Theme.of(context).primaryColor:Colors.grey.shade400,
              onTap:  () {
                if(quantity>0) {
                  CartModel c = new CartModel(quantity, product,totalp);
                  cartproducts.add(c);

                  // for(var i in product.addson){
                  //   i['added']=0;
                  // }
                  Fluttertoast.showToast(
                      msg: "تم الاضافة الى السلة",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey.shade200,
                      textColor: Colors.black,
                      fontSize: 16.0
                  );
                  Navigator.push(context, MaterialPageRoute(builder: (_) => DashboardScreen()));
                }
              } ,
            ),
            if(user==null)
              CustomButton(
                btnTxt: 'تسجيل الدخول للطلب',
                backgroundColor: Theme.of(context).primaryColor,
                onTap:  () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
                } ,
              )

          ]),
        )
    ));
  }
}


