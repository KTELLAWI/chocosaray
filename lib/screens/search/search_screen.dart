import 'package:flutter/material.dart';
import 'package:chocsarayi/utill/color_resources.dart';
import 'package:chocsarayi/utill/dimensions.dart';
import 'package:chocsarayi/utill/images.dart';
import 'package:chocsarayi/base/custom_text_field.dart';
import 'package:chocsarayi/screens/search/search_result_screen.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _searchController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hintText: 'اكتب عنصر للبحث',
                        isShowBorder: true,
                        isShowSuffixIcon: true,
                        suffixIconUrl: Images.search,
                        onSuffixTap: () {

                        },
                        controller: _searchController,
                        inputAction: TextInputAction.search,
                        isIcon: true,
                        onSubmit: (text) {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchResultScreen()));

                        },
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'الغاء',
                          style: Theme.of(context).textTheme.headline2.copyWith(color: ColorResources.getGreyBunkerColor(context)),
                        ))
                  ],
                ),
                // for resent search section

              ],
            ),),
      ),
    );
  }
}
