import 'package:chocsarayi/data/model/response/address_model.dart';
import 'package:flutter/material.dart';
import 'package:chocsarayi/utill/color_resources.dart';
import 'package:chocsarayi/utill/dimensions.dart';
import 'package:chocsarayi/utill/images.dart';
import 'package:chocsarayi/base/custom_button.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'add_new_address_screen.dart';





class SelectLocationScreen extends StatefulWidget {



  @override
  _SelectLocationScreenState createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {




  GoogleMapController _controller;
  TextEditingController _locationController = TextEditingController();
  Position position = new Position();
  CameraPosition cp;
  AddressModel address;
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.getPrimaryColor(context),
        elevation: 0,
        leading: SizedBox.shrink(),
        centerTitle: true,
        title: Text('اختر عنوان التوصيل'),
      ),
      body:Stack(
        clipBehavior: Clip.none,
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(position.latitude ?? 0.0, position.longitude ?? 0.0),
              zoom: 14,
            ),
            zoomControlsEnabled: false,
            compassEnabled: false,
            indoorViewEnabled: true,
            mapToolbarEnabled: true,
          onCameraIdle: () {
          },
          onCameraMove: ((_position) {
            AddNewAddressScreen.updatePosition(_position);
            setState(() {
              cp=_position;
            });
  }),
            // markers: Set<Marker>.of(locationProvider.markers),
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
              if (_controller != null) {
                AddNewAddressScreen.getCurrentLocation(mapController: _controller);
              }
            },
          ),
          address != null?
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE, vertical: 18.0),
            margin: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE, vertical: 23.0),
            decoration: BoxDecoration(color: Theme.of(context).accentColor, borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL)),
            child: Text(address.address
                ,
          )):SizedBox.shrink(),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    AddNewAddressScreen.getCurrentLocation(mapController: _controller);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_LARGE),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                      color: ColorResources.COLOR_WHITE,
                    ),
                    child: Icon(
                      Icons.my_location,
                      color: ColorResources.COLOR_PRIMARY,
                      size: 35,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                  child: CustomButton(
                    btnTxt: 'اختر الموقع',
                    onTap:(){
                      // AddNewAddressScreen.updatePosition(cp);
                      Navigator.pop(context);

                    }
                  ),
                ),
              ],
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                Images.marker,
                width: 25,
                height: 35,
              )),
        ],
      ),
    );
  }
}
