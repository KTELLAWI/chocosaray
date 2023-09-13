
import 'dart:async';
import 'dart:convert';
import 'package:chocsarayi/api/getdata.dart';
import 'package:chocsarayi/screens/address/address_screen.dart';
import 'package:chocsarayi/screens/checkout/order_successful_screen.dart';
import 'package:chocsarayi/screens/reservation_successful_screen.dart';
import 'package:chocsarayi/utill/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;


import '../main.dart';

String resp;
class Post {
  final String date;
  final String time;
  final String number;
  final String note;
  final String uid;
  final String kind;

  Post({this.date,this.uid,this.time,this.number,this.note,this.kind});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      date: json['date'],
      time: json['time'],
      number: json['number'],
      note: json['note'],
      uid: json['uid'],
      kind: json['kind'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map['date'] = date;
    map['time'] = time;
    map['number'] = number;
    map['note'] = note;
    map['uid'] = uid;
    map['kind'] = kind;
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


Future<String> dosendreservation(String date,String time,String note,String number,String kind, BuildContext c)async {
  final CREATE_POST_URL = url+'api/general-newTableRes';

  Post newPost = new Post(
   date: date,time: time,number: number,note: note,uid: user['userid'],kind: kind
  );
  print(newPost.toMap());
  Post p = await createPost(CREATE_POST_URL,
      body: newPost.toMap());
  //print(resp);


  final body = json.decode(resp);
  print(body);
  if(body['status']=="success"){

    Navigator
        .of(c)
        .pushReplacement(new MaterialPageRoute(builder: (BuildContext context) =>reservationSuccessfulScreen()));
  }
  else{

  }
  return body['type'];

}