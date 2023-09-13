
import 'dart:async';
import 'dart:convert';
import 'package:chocsarayi/api/getdata.dart';
import 'package:chocsarayi/screens/address/address_screen.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;


import '../main.dart';

String resp;
class Post {
  final String lat;
  final String long;

  Post({this.lat,this.long});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      lat: json['lat'],
      long: json['long'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map['lat'] = lat;
    map['long'] = long;
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


Future<String> dogetbranch(String lat,String long)async {
  final CREATE_POST_URL = url+'api/general-getbranch';

  Post newPost = new Post(
    lat: lat,long: long
  );
  print(newPost.toMap());
  Post p = await createPost(CREATE_POST_URL,
      body: newPost.toMap());
  //print(resp);


  final body = json.decode(resp);
  print(body);
  if(body['status']=="success"){
    bransh_name=body['branch_name'].toString();
    return body['branch'].toString();
  }
  else{
    return "";
    // Toast.show(body['message'], c, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);
  }

}