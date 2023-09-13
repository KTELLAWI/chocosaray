// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:chocsarayi/data/datasource/remote/dio/dio_client.dart';
// import 'package:chocsarayi/data/datasource/remote/exception/api_error_handler.dart';
// import 'package:chocsarayi/data/model/response/base/api_response.dart';
// import 'package:chocsarayi/data/model/response/chat_model.dart';
// import 'package:chocsarayi/helper/date_converter.dart';
//
// class ChatRepo {
//   final DioClient dioClient;
//   ChatRepo({@required this.dioClient});
//
//   Future<ApiResponse> getChatList() async {
//     try {
//       List<ChatModel> _chatList = [
//         ChatModel(id: 1, userId: 1, reply: 'Hi', message: null, createdAt: DateConverter.localDateToIsoString(DateTime.now().toUtc())),
//       ];
//       final response = Response(requestOptions: RequestOptions(path: ''), data: _chatList, statusCode: 200);
//       return ApiResponse.withSuccess(response);
//     } catch (e) {
//       return ApiResponse.withError(ApiErrorHandler.getMessage(e));
//     }
//   }
// }