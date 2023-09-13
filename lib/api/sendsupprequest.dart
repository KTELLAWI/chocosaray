
import 'dart:async';
import 'dart:convert';
import 'package:chocsarayi/db/Database.dart';
import 'package:chocsarayi/screens/dashboard/dashboard_screen.dart';
import 'package:chocsarayi/utill/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;


import '../main.dart';

String resp;
class Post {
  final String prov;
  final String area;

  Post({this.prov,this.area});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      prov: json['prov'],
      area: json['area'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map['prov'] = prov;
    map['area'] = area;


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


Future<String> dosendsupprequest(String prov,String area,BuildContext c)async {
  final CREATE_POST_URL = url+'api/general-sendsupprequest';

  Post newPost = new Post(
   prov: prov,area: area
  );
  Post p = await createPost(CREATE_POST_URL,
      body: newPost.toMap());
  //print(resp);


  final body = json.decode(resp);
  print(body);
  if(body['status']=="success"||body['status']=="success2"){
    Fluttertoast.showToast(
        msg: "تم ارسال طلبك بنجاح",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorResources.COLOR_PRIMARY,
        textColor: Colors.white,
        fontSize: 16.0
    );
    Navigator.pop(c);
  }
  else{
    Fluttertoast.showToast(
        msg: "حدث خطأ ما",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorResources.COLOR_PRIMARY,
        textColor: Colors.white,
        fontSize: 16.0
    );
    // Toast.show(body['message'], c, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);
  }
  return body['type'];

}