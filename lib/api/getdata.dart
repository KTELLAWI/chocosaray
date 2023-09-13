

//newstypes
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../main.dart';





//main categories list
List maincategories = List();
Future<String> getmaincategoriesSW() async {
  String u;
  u = url+"api/general-get-maincategories?bid="+bransh;
  var res = await http
      .get(Uri.parse(u), headers: {"Accept": "application/json"});
  var resBody = json.decode(res.body);
  maincategories = resBody;
  print(resBody);
  print (maincategories);
  return "Sucess";
}
Future<List> getmaincategories()async{
  await getmaincategoriesSW();
  return maincategories;
}




List alloffers = List();
Future<String> getalloffersSW() async {
  String u;
  u = url+"api/general-get-AllOffers?bid="+bransh;
  var res = await http
      .get(Uri.parse(u), headers: {"Accept": "application/json"});
  var resBody = json.decode(res.body);
  alloffers = resBody;
  print (alloffers);
  return "Sucess";
}
Future<List> getalloffers()async{
  await getalloffersSW();
  return alloffers;
}

List fetproducts = List();
Future<String> getfetproductsSW() async {
  String u;
  u = url+"api/general-getFeaturedProducts?bid="+bransh;
  var res = await http
      .get(Uri.parse(u), headers: {"Accept": "application/json"});
  var resBody = json.decode(res.body);
  fetproducts = resBody;
  print (fetproducts);
  return "Sucess";
}
Future<List> getfetproducts()async{
  await getfetproductsSW();
  return fetproducts;
}





List searchproducts = List();
Future<String> getsearchproductsSW(String val) async {
  String u;
  u = url+"api/general-getsearchProducts?bid="+bransh+"&name="+val;
  var res = await http
      .get(Uri.parse(u), headers: {"Accept": "application/json"});
  var resBody = json.decode(res.body);
  searchproducts = resBody;
  print (searchproducts);
  return "Sucess";
}
Future<List> getsearchproducts(String val)async{
  await getsearchproductsSW(val);
  return searchproducts;
}



List categoryproducts = List();
Future<String> getcategoryproductsSW(String id) async {
  String u;
  u = url+"api/general-getCategoryProducts?id="+id;
  var res = await http
      .get(Uri.parse(u), headers: {"Accept": "application/json"});
  var resBody = json.decode(res.body);
  categoryproducts = resBody;
  print (categoryproducts);
  return "Sucess";
}
Future<List> getcategoryproducts(String id)async{
  await getcategoryproductsSW(id);
  return categoryproducts;
}


List myaddresses = List();
Future<String> getmyaddressesSW(String id) async {
  String u;
  u = url+"api/general-getMyaddress?id="+id;
  var res = await http
      .get(Uri.parse(u), headers: {"Accept": "application/json"});
  var resBody = json.decode(res.body);
  myaddresses = resBody;
  print (myaddresses);
  return "Sucess";
}
Future<List> getmyaddresses(String id)async{
  await getmyaddressesSW(id);
  return myaddresses;
}



List myorders = List();
Future<String> getmyordersSW(String id) async {
  String u;
  u = url+"api/general-getMyOrders?id="+id;
  var res = await http
      .get(Uri.parse(u), headers: {"Accept": "application/json"});
  var resBody = json.decode(res.body);
  myorders = resBody;
  print (myorders);
  return "Sucess";
}
Future<List> getmyorders(String id)async{
  await getmyordersSW(id);
  return myorders;
}

Map orderdetails = Map();
Future<String> getorderdetailsSW(String id) async {
  String u;
  u = url+"api/general-getOrderdetails?oid="+id;
  var res = await http
      .get(Uri.parse(u), headers: {"Accept": "application/json"});
  var resBody = json.decode(res.body);
  print(resBody);
  orderdetails = resBody;
  print (myorders);
  return "Sucess";
}
Future<Map> getorderdetails(String id)async{
  await getorderdetailsSW(id);
  return orderdetails;
}

Map mywallet = Map();
Future<String> getmywalletSW(String id) async {
  String u;
  u = url+"api/general-getMyWallet?id="+id;
  var res = await http
      .get(Uri.parse(u), headers: {"Accept": "application/json"});
  var resBody = json.decode(res.body);
  mywallet = resBody;
  print (mywallet);
  return "Sucess";
}
Future<Map> getmywallet(String id)async{
  await getmywalletSW(id);
  return mywallet;
}

Map mypoints = Map();
Future<String> getmypointsSW(String id) async {
  String u;
  u = url+"api/general-getMyPoints?id="+id;
  var res = await http
      .get(Uri.parse(u), headers: {"Accept": "application/json"});
  var resBody = json.decode(res.body);
  mypoints = resBody;
  print (mypoints);
  return "Sucess";
}
Future<Map> getmypoints(String id)async{
  await getmypointsSW(id);
  return mypoints;
}



List myfavorate = List();
Future<String> getmyfavorateSW(String id) async {
  String u;
  u = url+"api/general-getMyFavorates?id="+id;
  var res = await http
      .get(Uri.parse(u), headers: {"Accept": "application/json"});
  var resBody = json.decode(res.body);
  myfavorate = resBody;
  print (myfavorate);
  return "Sucess";
}
Future<List> getmyfavorate(String id)async{
  await getmyfavorateSW(id);
  return myfavorate;
}






List myreservations = List();
Future<String> getmyreservationsSW(String id) async {
  String u;
  u = url+"api/general-getMyTableRes?id="+id;
  var res = await http
      .get(Uri.parse(u), headers: {"Accept": "application/json"});
  var resBody = json.decode(res.body);
  myreservations = resBody;
  print (myreservations);
  return "Sucess";
}
Future<List> getmyreservations(String id)async{
  await getmyreservationsSW(id);
  return myreservations;
}


List ourbranches = List();
Future<String> getourbranchesSW() async {
  String u;
  u = url+"api/general-getaddresses";
  var res = await http
      .get(Uri.parse(u), headers: {"Accept": "application/json"});
  var resBody = json.decode(res.body);
  ourbranches = resBody;
  print (ourbranches);
  return "Sucess";
}
Future<List> getourbranches()async{
  await getourbranchesSW();
  return ourbranches;
}


// //main sub categories list
// List subcategories = List();
// Future<String> getsubcategoriesSW(String id) async {
//   String u;
//   u = url+"api/general-get-subcategories?id="+id;
//   var res = await http
//       .get(Uri.encodeFull(u), headers: {"Accept": "application/json"});
//   var resBody = json.decode(res.body);
//   subcategories = resBody;
//   print(resBody);
//   print (subcategories);
//   return "Sucess";
// }
// Future<List> getsubcategories(String id)async{
//   await getsubcategoriesSW(id);
//   return subcategories;
// }
//
//
//
//
// List restcategory = List();
// Future<String> getrestcategorySW(String id) async {
//   String u;
//   u = url+"api/general-getAllResturantsCategories?id="+id;
//   var res = await http
//       .get(Uri.encodeFull(u), headers: {"Accept": "application/json"});
//   var resBody = json.decode(res.body);
//   restcategory = resBody;
//   print(resBody);
//   print (restcategory);
//   return "Sucess";
// }
// Future<List> getrestcategory(String id)async{
//   await getrestcategorySW(id);
//   return restcategory;
// }
//
//
// List restfood = List();
// Future<String> getrestfoodSW(String rid,String cid) async {
//   String u;
//   u = url+"api/general-getCategoryResturantsFood?rid="+rid+"&cid="+cid;
//   var res = await http
//       .get(Uri.encodeFull(u), headers: {"Accept": "application/json"});
//   var resBody = json.decode(res.body);
//   restfood = resBody;
//   print(resBody);
//   print (restfood);
//   return "Sucess";
// }
// Future<List> getrestfood(String rid,String cid)async{
//   await getrestfoodSW(rid,cid);
//   return restfood;
// }
//
//
//
//
// List restallfood = List();
// Future<String> getrestallfoodSW(String rid) async {
//   String u;
//   u = url+"api/general-getCategoryResturantsallFood?rid="+rid;
//   var res = await http
//       .get(Uri.encodeFull(u), headers: {"Accept": "application/json"});
//   var resBody = json.decode(res.body);
//   restallfood = resBody;
//   print(resBody);
//   print (restallfood);
//   return "Sucess";
// }
// Future<List> getrestallfood(String rid)async{
//   await getrestallfoodSW(rid);
//   return restallfood;
// }
//
//
// List myorders = List();
// Future<String> getmyordersSW(String id) async {
//   String u;
//   u = url+"api/general-getAllOrders?id="+id;
//
//   var res = await http
//       .get(Uri.encodeFull(u), headers: {"Accept": "application/json"});
//   var resBody = json.decode(res.body);
//   print(resBody);
//   myorders = resBody;
//   print (myorders);
//   return "Sucess";
// }
// Future<List> getmyorders(String id)async{
//   await getmyordersSW(id);
//   return myorders;
// }
//
//
//
//
//
//
// //main sub categories list
// List appsitting = List();
// Future<String> getappsittingSW() async {
//   String u;
//   u = url+"api/general-getAppSittings";
//   var res = await http
//       .get(Uri.encodeFull(u), headers: {"Accept": "application/json"});
//   var resBody = json.decode(res.body);
//   appsitting = resBody;
//   print(resBody);
//   print (appsitting);
//   return "Sucess";
// }
// Future<List> getappsitting()async{
//   await getappsittingSW();
//   return appsitting;
// }
//
//
// List adverts = List();
// Future<String> getadvertsSW() async {
//   String u;
//   u = url+"api/general-getAdminads";
//   var res = await http
//       .get(Uri.encodeFull(u), headers: {"Accept": "application/json"});
//   var resBody = json.decode(res.body);
//   adverts = resBody;
//   print(resBody);
//   print (adverts);
//   return "Sucess";
// }
// Future<List> getadverts()async{
//   await getadvertsSW();
//   return adverts;
// }
//
//
//
// List newdriverorders = List();
// Future<String> getnewdriverordersSW(String id) async {
//   String u;
//   u = url+"api/general-getDriverNewOrders?id="+id;
//   print(u);
//   var res = await http
//       .get(Uri.encodeFull(u), headers: {"Accept": "application/json"});
//   var resBody = json.decode(res.body);
//   print(resBody);
//   newdriverorders = resBody;
//   print(resBody);
//   print (newdriverorders);
//   return "Sucess";
// }
// Future<List> getnewdriverorders(String id)async{
//   await getnewdriverordersSW(id);
//   return newdriverorders;
// }
//
//
// List olddriverorders = List();
// Future<String> getolddriverordersSW(String id) async {
//   String u;
//   u = url+"api/general-getDriverOldOrders?id="+id;
//   var res = await http
//       .get(Uri.encodeFull(u), headers: {"Accept": "application/json"});
//   var resBody = json.decode(res.body);
//   print(resBody);
//   olddriverorders = resBody;
//   print(resBody);
//   print (olddriverorders);
//   return "Sucess";
// }
// Future<List> getolddriverorders(String id)async{
//   await getolddriverordersSW(id);
//   return olddriverorders;
// }
//
//
//
//
// List categoryproducts = List();
// Future<String> getcategoryproductsSW(String id) async {
//   String u;
//   u = url+"api/general-getCategoryProducts?id="+id;
//   var res = await http
//       .get(Uri.encodeFull(u), headers: {"Accept": "application/json"});
//   var resBody = json.decode(res.body);
//   print(resBody);
//   categoryproducts = resBody;
//   print(resBody);
//   print (categoryproducts);
//   return "Sucess";
// }
// Future<List> getcategoryproducts(String id)async{
//   await getcategoryproductsSW(id);
//   return categoryproducts;
// }
//
// List searchproducts = List();
// Future<String> getsearchproductsSW(String name) async {
//   String u;
//   u = url+"api/general-getsearchProducts?name="+name;
//   var res = await http
//       .get(Uri.encodeFull(u), headers: {"Accept": "application/json"});
//   var resBody = json.decode(res.body);
//   print(resBody);
//   searchproducts = resBody;
//   print(resBody);
//   print (searchproducts);
//   return "Sucess";
// }
// Future<List> getsearchproducts(String name)async{
//   await getsearchproductsSW(name);
//   return searchproducts;
// }
//
//
//
//
// List searchfoods = List();
// Future<String> getsearchfoodsSW(String name) async {
//   String u;
//   u = url+"api/general-getsearchFoods?name="+name;
//   var res = await http
//       .get(Uri.encodeFull(u), headers: {"Accept": "application/json"});
//   var resBody = json.decode(res.body);
//   print(resBody);
//   searchfoods = resBody;
//   print(resBody);
//   print (searchfoods);
//   return "Sucess";
// }
// Future<List> getsearchfoods(String name)async{
//   await getsearchfoodsSW(name);
//   return searchfoods;
// }