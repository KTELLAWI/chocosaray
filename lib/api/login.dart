
import 'dart:async';
import 'dart:convert';
import 'package:chocsarayi/api/savetoken.dart';
import 'package:chocsarayi/db/Database.dart';
import 'package:chocsarayi/screens/dashboard/dashboard_screen.dart';
import 'package:chocsarayi/utill/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;


import '../main.dart';

String resp;
class Post {
  final String phone;
  final String name;
  final String dob;

  Post({this.phone,this.name,this.dob});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      phone: json['phone'],
      name: json['name'],
      dob: json['dob'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map['phone'] = phone;
    map['name'] = name;
    map['dob'] = dob;

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


Future<String> douserlogin(String phone,String name, String dob,BuildContext c)async {
  final CREATE_POST_URL = url+'api/general-loginappuser';

  Post newPost = new Post(
   phone: phone,name: name,dob: dob
  );
  Post p = await createPost(CREATE_POST_URL,
      body: newPost.toMap());
  //print(resp);


  final body = json.decode(resp);
  print(body);
  if(body['status']=="success"||body['status']=="success2"){
    // Toast.show("Logged IN !!", c, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);
    await DBProvider.db.deleteAll();
    await DBProvider.db.newClient(name,body['id'].toString());
    // await Pushy.subscribe('users');
    user = await DBProvider.db.getClient(1);
    // await sendusernotificationid(body['id'].toString(), notid, lang);
    dosavetoken(body['id'].toString());
    Fluttertoast.showToast(
        msg: "تم تسجيل الدخول",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade200,
        textColor: Colors.black,
        fontSize: 16.0
    );
    Navigator
        .of(c)
        .pushReplacement(new MaterialPageRoute(builder: (BuildContext context) =>DashboardScreen()));

  }
  else{
    Fluttertoast.showToast(
        msg: "حدث خطأ يرجى اعادة المحاولة",
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