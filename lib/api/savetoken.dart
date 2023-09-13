
import 'dart:async';
import 'dart:convert';
import 'package:chocsarayi/db/Database.dart';
import 'package:chocsarayi/screens/dashboard/dashboard_screen.dart';
import 'package:chocsarayi/utill/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


import '../main.dart';

String resp;
class Post {
  final String userid;
  final String token;

  Post({this.token,this.userid});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      token: json['token'],
      userid: json['userid'],

    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map['token'] = token;
    map['userid'] = userid;

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


Future<String> dosavetoken(String id)async {
  final CREATE_POST_URL = url+'api/general-savetoken';
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token=prefs.getString("token");
  Post newPost = new Post(
     token: token,userid: id
   );
  Post p = await createPost(CREATE_POST_URL,
      body: newPost.toMap());
  //print(resp);


  final body = json.decode(resp);
  print(body);

  return body['type'];

}