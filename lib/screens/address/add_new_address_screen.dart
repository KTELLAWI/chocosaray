import 'package:chocsarayi/api/updateaddress.dart';
import 'package:flutter/material.dart';
import 'package:chocsarayi/data/model/response/address_model.dart';
import 'package:chocsarayi/data/model/response/config_model.dart';
import 'package:chocsarayi/utill/color_resources.dart';
import 'package:chocsarayi/utill/dimensions.dart';
import 'package:chocsarayi/utill/images.dart';
import 'package:chocsarayi/base/custom_app_bar.dart';
import 'package:chocsarayi/base/custom_button.dart';
import 'package:chocsarayi/base/custom_text_field.dart';
import 'package:chocsarayi/screens/address/select_location_screen.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:chocsarayi/api/addaddress.dart';
class MainAddNewAddressScreen extends StatefulWidget{
  final bool isEnableUpdate;
  final bool fromCheckout;
  final AddressModel address;
  final double amount;
  final String orderType;

  MainAddNewAddressScreen({this.isEnableUpdate = false, this.address, this.fromCheckout = false,this.amount=0,this.orderType=''});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddNewAddressScreen(isEnableUpdate: isEnableUpdate,address: address,fromCheckout: fromCheckout);
  }

}


class AddNewAddressScreen extends State<MainAddNewAddressScreen> {

  static GoogleMapController _controller;
  static Position _position = new Position();
  static void updatePosition(CameraPosition position) async {
    _position = Position(latitude: position.target.latitude, longitude: position.target.longitude);
    if (_controller != null) {
      _controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(
              position.target.latitude, position.target.longitude), zoom: 17)));
    }
  }

  static void getCurrentLocation({GoogleMapController mapController}) async {
    try {
      Position newLocalData = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      if (mapController != null) {
        mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(newLocalData.latitude, newLocalData.longitude), zoom: 17)));
        _position = Position(latitude: newLocalData.latitude, longitude: newLocalData.longitude);

        final currentCoordinates = new Coordinates(newLocalData.latitude, newLocalData.longitude);
        var currentAddresses = await Geocoder.local.findAddressesFromCoordinates(currentCoordinates);
      }
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }




  final bool isEnableUpdate;
  final bool fromCheckout;
  final AddressModel address;
  List <Map>AllAddressType=[];



  Position position = new Position();

  AddNewAddressScreen({this.isEnableUpdate = false, this.address, this.fromCheckout = false});
  final TextEditingController _addressnameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _contactPersonNameController = TextEditingController();
  final TextEditingController _contactPersonNumberController = TextEditingController();
  final FocusNode _addressNode = FocusNode();
  final FocusNode _nameNode = FocusNode();
  final FocusNode _numberNode = FocusNode();
  final FocusNode _addressnameNode = FocusNode();
  String type="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map hom=new Map();
    hom['name']="المنزل";
    hom['select']=0;
    AllAddressType.add(hom);
    Map work=new Map();
    work['name']="العمل";
    work['select']=0;
    AllAddressType.add(work);
    Map other=new Map();
    other['name']="غير ذلك";
    other['select']=0;
    getCurrentLocation();
    AllAddressType.add(other);
    if(isEnableUpdate){
      _addressnameController.text=address.addressType;
      _contactPersonNameController.text=address.contactPersonName;
      _contactPersonNumberController.text=address.contactPersonNumber;
      _locationController.text=address.address;
    }
  }
  // List AllAddressType=[];
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: CustomAppBar(title: isEnableUpdate ? 'تعديل العنوان': 'اضافة عنوان جديد'),
      body: Directionality(textDirection: TextDirection.rtl,child:

      Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          child:  Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      Container(
                        height: 126,
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              GoogleMap(
                                mapType: MapType.normal,
                                initialCameraPosition: CameraPosition(
                                  target: isEnableUpdate
                                      ? LatLng(double.parse(address.latitude) ?? 0.0, double.parse(address.longitude) ?? 0.0)
                                      : LatLng(_position.latitude ?? 0.0, _position.longitude ?? 0.0),
                                  zoom: 12,
                                ),
                                onTap: (latLng) {
                                  print(latLng);
                                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => SelectLocationScreen()));
                                },
                                zoomControlsEnabled: false,
                                compassEnabled: false,
                                indoorViewEnabled: true,
                                mapToolbarEnabled: false,
                                onCameraIdle: () {
                                  // locationProvider.dragableAddress();
                                },
                                onCameraMove: ((_position) {

                                }
                                ),
                                onMapCreated: (GoogleMapController controller) {
                                  _controller = controller;
                                  if (_controller != null) {
                                    getCurrentLocation(mapController: _controller);
                                  }
                                },
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
                              Positioned(
                                bottom: 10,
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    // locationProvider.getCurrentLocation(mapController: _controller);
                                  },
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_LARGE),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                                      color: ColorResources.COLOR_WHITE,
                                    ),
                                    child: Icon(
                                      Icons.my_location,
                                      color: ColorResources.COLOR_PRIMARY,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Center(
                            child: Text(
                              'اضغط على الخريطة لتحديد الموقع',
                              style:
                              Theme.of(context).textTheme.headline2.copyWith(color: ColorResources.getGreyBunkerColor(context), fontSize: Dimensions.FONT_SIZE_SMALL),
                            )),
                      ),

                      // for label us
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: 24.0),
                      //   child: Text(
                      //     'النوع',
                      //     style:
                      //     Theme.of(context).textTheme.headline3.copyWith(color: ColorResources.getGreyBunkerColor(context), fontSize: Dimensions.FONT_SIZE_LARGE),
                      //   ),
                      // ),
                      //
                      // Container(
                      //   height: 50,
                      //   child: ListView.builder(
                      //     shrinkWrap: true,
                      //     scrollDirection: Axis.horizontal,
                      //     physics: BouncingScrollPhysics(),
                      //     itemCount: AllAddressType.length,
                      //     itemBuilder: (context, index) => InkWell(
                      //       onTap: () {
                      //          setState(() {
                      //            for(var i in AllAddressType){
                      //              i['select']=0;
                      //            }
                      //            type= AllAddressType[index]['name'];
                      //            AllAddressType[index]['select']=1;
                      //          });
                      //        },
                      //       child: Container(
                      //         padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT, horizontal: Dimensions.PADDING_SIZE_LARGE),
                      //         margin: EdgeInsets.only(right: 17),
                      //         decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(
                      //               Dimensions.PADDING_SIZE_SMALL,
                      //             ),
                      //             border: Border.all(
                      //                 color:
                      //                 ColorResources.COLOR_PRIMARY ),
                      //             color:  AllAddressType[index]['select']==0?ColorResources.SEARCH_BG:Colors.orangeAccent.shade400),
                      //         child: Text(
                      //           AllAddressType[index]['name'],
                      //           style: Theme.of(context).textTheme.headline2.copyWith(
                      //               color: ColorResources.COLOR_PRIMARY) ,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Text(
                        'اسم العنوان',
                        style: Theme.of(context).textTheme.headline2.copyWith(color: ColorResources.getHintColor(context)),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      CustomTextField(
                        hintText: 'اسم العنوان',
                        isShowBorder: true,
                        inputType: TextInputType.streetAddress,
                        inputAction: TextInputAction.next,
                        focusNode: _addressnameNode,
                        nextFocus: _addressNode,
                        controller: _addressnameController,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        child: Text(
                          'عنوان التوصيل',
                          style:
                          Theme.of(context).textTheme.headline3.copyWith(color: ColorResources.getGreyBunkerColor(context), fontSize: Dimensions.FONT_SIZE_LARGE),
                        ),
                      ),

                      // for Address Field
                      Text(
                        'العنوان',
                        style: Theme.of(context).textTheme.headline2.copyWith(color: ColorResources.getHintColor(context)),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      CustomTextField(
                        hintText: 'العنوان',
                        isShowBorder: true,
                        inputType: TextInputType.streetAddress,
                        inputAction: TextInputAction.next,
                        focusNode: _addressNode,
                        nextFocus: _nameNode,
                        controller: _locationController,
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                      // for Contact Person Name
                      Text(
                        'الاسم',
                        style: Theme.of(context).textTheme.headline2.copyWith(color: ColorResources.getHintColor(context)),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      CustomTextField(
                        hintText: 'أدخل الاسم',
                        isShowBorder: true,
                        inputType: TextInputType.name,
                        controller: _contactPersonNameController,
                        focusNode: _nameNode,
                        nextFocus: _numberNode,
                        inputAction: TextInputAction.next,
                        capitalization: TextCapitalization.words,
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                      // for Contact Person Number
                      Text(
                        'رقم التواصل',
                        style: Theme.of(context).textTheme.headline2.copyWith(color: ColorResources.getHintColor(context)),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      CustomTextField(
                        hintText: 'ادخل رقم التواصل',
                        isShowBorder: true,
                        inputType: TextInputType.phone,
                        inputAction: TextInputAction.done,
                        focusNode: _numberNode,
                        controller: _contactPersonNumberController,
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                      SizedBox(
                        height: Dimensions.PADDING_SIZE_DEFAULT,
                      )
                    ],
                  ),
                ),
              ),

              SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
              Container(
                  height: 50.0,
                  child:  CustomButton(
                    btnTxt: isEnableUpdate ? 'تعديل الموقع' :'حفظ الموقع',
                    onTap: () {
                      if(isEnableUpdate){
                        doupdateaddress("main",_addressnameController.text,_locationController.text,_contactPersonNameController.text,_contactPersonNumberController.text,_position.latitude.toString(),_position.longitude.toString(),widget.fromCheckout,widget.amount,widget.orderType,address.id.toString(),context);
                      }
                      else{
                        doaddaddress("main",_addressnameController.text,_locationController.text,_contactPersonNameController.text,_contactPersonNumberController.text,_position.latitude.toString(),_position.longitude.toString(),widget.fromCheckout,widget.amount,widget.orderType,context);
                      }
                    },
                  )
              )
            ],
          )
      )
        ,)

    );
  }
}
