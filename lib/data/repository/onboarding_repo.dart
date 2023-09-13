import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:chocsarayi/data/datasource/remote/dio/dio_client.dart';
import 'package:chocsarayi/data/datasource/remote/exception/api_error_handler.dart';
import 'package:chocsarayi/data/model/response/base/api_response.dart';
import 'package:chocsarayi/data/model/response/onboarding_model.dart';
import 'package:chocsarayi/utill/images.dart';

class OnBoardingRepo {
  final DioClient dioClient;

  OnBoardingRepo({@required this.dioClient});

  Future<ApiResponse> getOnBoardingList(BuildContext context) async {
    try {
      List<OnBoardingModel> onBoardingList = [
        OnBoardingModel(Images.onboarding_one, 'Select you choice and order',  'Many choices'),
        OnBoardingModel(Images.onboarding_two, 'Select your location for delivering', 'Fast delivery'),
        OnBoardingModel(Images.onboarding_three, 'We will delivering to your door', 'To your door'),
      ];

      Response response = Response(requestOptions: RequestOptions(path: ''), data: onBoardingList, statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
