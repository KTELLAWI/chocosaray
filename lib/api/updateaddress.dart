
import 'dart:async';
import 'dart:convert';
import 'package:chocsarayi/api/getdata.dart';
import 'package:chocsarayi/screens/address/address_screen.dart';
import 'package:chocsarayi/screens/checkout/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;


import '../main.dart';

String resp;
class Post {
  final String title;
  final String type;
  final String address;
  final String name;
  final String phone;
  final String lat;
  final String long;
  final String id;

  Post({this.title, this.type,this.address,this.name,this.phone,this.lat,this.long,this.id});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title'],
      type: json['type'],
      address: json['address'],
      name: json['name'],
      phone: json['phone'],
      lat: json['lat'],
      long: json['long'],
      id: json['id'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map['title'] = title;
    map['type'] = type;
    map['address'] = address;
    map['name'] = name;
    map['phone'] = phone;
    map['lat'] = lat;
    map['long'] = long;
    map['id'] = id;
    return map;
  }
}

Future<Post> createPost(String url, {Map body}) async {
  return http.post(Uri.parse(url), body: body).then((http.Response response) {
    final int statusCode = response.statusCode;
    print(response.body);
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");

    }
    String u = utf8.decode(response.bodyBytes);
    resp=u;

    return Post.fromJson(json.decode(response.body));
  });
}


Future<String> doupdateaddress(String title,String type,String address,String name,String phone,String lat,String long,bool fcheck,double amount,String tt,String id, BuildContext c)async {
  final CREATE_POST_URL = url+'api/general-updateaddress';

  Post newPost = new Post(
    title: title,type: type,address: address,name: name,phone: phone,lat: lat,long: long,id: id
  );
  print(newPost.toMap());
  Post p = await createPost(CREATE_POST_URL,
      body: newPost.toMap());
  //print(resp);


  final body = json.decode(resp);
  print(body);

  if(body['status']=="success") {
    Fluttertoast.showToast(
        msg: "تم اضافة العنوان",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade200,
        textColor: Colors.black,
        fontSize: 16.0
    );

    if(!fcheck){
    Navigator
        .of(c)
        .pushReplacement(new MaterialPageRoute(
        builder: (BuildContext context) => AddressScreen()));
  }
    else{
      Navigator
          .of(c)
          .pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) =>  CheckoutScreen(
            amount: amount,
          )));
    }

  }


  return body['type'];

}