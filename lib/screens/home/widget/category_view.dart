import 'package:chocsarayi/api/getdata.dart';
import 'package:chocsarayi/data/model/response/category_model.dart';
import 'package:chocsarayi/main.dart';
import 'package:chocsarayi/screens/category/category_screen.dart';
import 'package:flutter/material.dart';
import 'package:chocsarayi/utill/color_resources.dart';
import 'package:chocsarayi/utill/dimensions.dart';
import 'package:chocsarayi/utill/styles.dart';
import 'package:chocsarayi/base/title_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';


class CategoryView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return _CategoryView();
  }

}


class _CategoryView extends State<CategoryView> {

  _CategoryView(){
    List<CategoryModel> categoryList2=[];
    getmaincategories().then((value){
      for(var c in value){
        CategoryModel cm = new CategoryModel(id: c['id'],name: c['arabic_name'],image: url+"categories_icons/"+c['icon']);
        categoryList2.add(cm);
      }
      setState(() {
        categoryList=categoryList2;
      });
    });
  }

  List<CategoryModel> categoryList;
  @override
  Widget build(BuildContext context) {
    return
    Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: TitleWidget(title: 'كل الأصناف'),
        ),
        SizedBox(
          height: 90,
          child: categoryList != null ? categoryList.length > 0 ? ListView.builder(
            itemCount: categoryList.length,
            padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CategoryScreen(categoryid: categoryList[index].id,title: categoryList[index].name,))),
                child: Padding(
                  padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
                  child: Column(children: [

                    ClipOval(
                      child: Image.network(
                        categoryList[index].image,
                        width: 65, height: 65, fit: BoxFit.cover,
                      ),
                    ),

                    Text(
                      categoryList[index].name,
                      style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                  ]),
                ),
              );
            },
          ) : Center(child: Text('No category available', )) : CategoryShimmer(),
        ),
      ],
    );
  }
}

class CategoryShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        itemCount: 10,
        padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              enabled: true,
              child: Column(children: [
                Container(
                  height: 65, width: 65,
                  decoration: BoxDecoration(
                    color: ColorResources.COLOR_WHITE,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(height: 5),
                Container(height: 10, width: 50, color: ColorResources.COLOR_WHITE),
              ]),
            ),
          );
        },
      ),
    );
  }
}

