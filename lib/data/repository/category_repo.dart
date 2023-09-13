import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:chocsarayi/data/datasource/remote/dio/dio_client.dart';
import 'package:chocsarayi/data/datasource/remote/exception/api_error_handler.dart';
import 'package:chocsarayi/data/model/response/base/api_response.dart';
import 'package:chocsarayi/data/model/response/category_model.dart';
import 'package:chocsarayi/data/model/response/product_model.dart';
import 'package:chocsarayi/data/repository/products.dart';
import 'package:chocsarayi/utill/images.dart';

class CategoryRepo {
  final DioClient dioClient;
  CategoryRepo({@required this.dioClient});

  Future<ApiResponse> getCategoryList() async {
    try {
      List<CategoryModel> _categoryList = [
        CategoryModel(image: Images.product_7, id: 1, name: 'Bengali'),
        CategoryModel(image: Images.product_4, id: 2, name: 'First-Food'),
        CategoryModel(image: Images.product_11, id: 3, name: 'Breakfast'),
        CategoryModel(image: Images.product_2, id: 4, name: 'Pizza'),
        CategoryModel(image: Images.product_9, id: 5, name: 'Lunch'),
        CategoryModel(image: Images.product_6, id: 6, name: 'Burger'),
        CategoryModel(image: Images.product_3, id: 7, name: 'Dinner'),
      ];
      final response = Response(requestOptions: RequestOptions(path: ''), data: _categoryList, statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getSubCategoryList(String parentID) async {
    try {
      List<CategoryModel> _categoryList = [
        CategoryModel(image: Images.product_1, id: 1, name: 'Bengali'),
        CategoryModel(image: Images.product_2, id: 1, name: 'First-Food'),
      ];
      final response = Response(requestOptions: RequestOptions(path: ''), data: _categoryList, statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getCategoryProductList(String categoryID) async {
    try {
      List<Product> _productList = [];
      _productList.addAll(Products.products.products);
      _productList.addAll(Products.products.products);
      final response = Response(requestOptions: RequestOptions(path: ''), data: _productList, statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}