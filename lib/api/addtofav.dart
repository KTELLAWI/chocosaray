
import 'dart:async';
import 'dart:convert';
import 'package:chocsarayi/api/getdata.dart';
import 'package:chocsarayi/screens/address/address_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;


import '../main.dart';

String resp;
class Post {
  final String pid;
  final String uid;

  Post({this.pid,this.uid});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      pid: json['pid'],
      uid: json['uid'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map['pid'] = pid;
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


Future<String> doaddtofav(String pid, BuildContext c)async {
  final CREATE_POST_URL = url+'api/general-NewFavorate';

  Post newPost = new Post(
    pid: pid,uid: user['userid']
  );
  print(newPost.toMap());
  Post p = await createPost(CREATE_POST_URL,
      body: newPost.toMap());
  //print(resp);


  final body = json.decode(resp);
  print(body);
  if(body['status']=="success"){
    Fluttertoast.showToast(
        msg: "تمت اضافته للمفضلة",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade200,
        textColor: Colors.black,
        fontSize: 16.0
    );
  }
  else{
    // Toast.show(body['message'], c, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);
  }
  return body['type'];

}