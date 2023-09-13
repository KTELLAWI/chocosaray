
import 'dart:async';
import 'dart:convert';
import 'package:chocsarayi/screens/checkout/order_successful_screen.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;


import '../main.dart';

String resp;
class Post {
  final String products;
  final String uid;
  final String aid;
  final String bid;
  final String note;
  final String amount;
  Post({this.aid,this.uid,this.products,this.bid,this.note,this.amount});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      aid: json['aid'],
      uid: json['uid'],
      bid: json['bid'],
      note: json['note'],
      amount: json['amount'],
      products: json['products'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map['aid'] = aid;
    map['uid'] = uid;
    map['bid'] = bid;
    map['note'] = note;
    map['amount'] = amount;
    map['products'] = products;
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


Future<String> dosendorder(String aid,String products,String note,String amount, BuildContext c)async {
  final CREATE_POST_URL = url+'api/general-sendneworders';

  Post newPost = new Post(
    aid: aid,products: products,uid: user['userid'],bid: bransh ,note: note,amount: amount
  );
  print(newPost.toMap());
  Post p = await createPost(CREATE_POST_URL,
      body: newPost.toMap());
  //print(resp);


  final body = json.decode(resp);
  print(body);
  if(body['status']=="success"){
    cartproducts.clear();
    Navigator
        .of(c)
        .pushReplacement(new MaterialPageRoute(builder: (BuildContext context) =>OrderSuccessfulScreen(orderID: body['orderid'].toString(),)));
  }
  else{
    // Toast.show(body['message'], c, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);
  }
  return body['type'];

}