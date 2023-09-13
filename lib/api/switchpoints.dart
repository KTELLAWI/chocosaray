
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
  final String uid;
  final String amount;

  Post({this.amount,this.uid});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      amount: json['amount'],
      uid: json['uid'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map['amount'] = amount;
    map['uid'] = uid;

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


Future<String> doswitchpoints(String amount, BuildContext c)async {
  final CREATE_POST_URL = url+'api/general-switchPoints';

  Post newPost = new Post(
   amount: amount,uid: user['userid']
  );
  Post p = await createPost(CREATE_POST_URL,
      body: newPost.toMap());
  //print(resp);


  final body = json.decode(resp);
  print(body);
  if(body['status']=="success"||body['status']=="success2"){
    Fluttertoast.showToast(
        msg: "تم تحويل النقاط بنجاح",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorResources.COLOR_PRIMARY,
        textColor: Colors.white,
        fontSize: 16.0
    );
    Navigator
        .of(c)
        .pushReplacement(new MaterialPageRoute(builder: (BuildContext context) =>DashboardScreen()));

  }
  else{

  }
  return body['type'];

}