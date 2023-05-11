import 'dart:convert';

import 'package:api_dio/Constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          headers: {"Content-Type": 'application/json'}),
    );
  }

  static Future<Response?> getData(
      {@required String? endPoint,
      Map<String, dynamic>? query,
      @required String? token}) async {
    dio!.options.headers = {'Authorization': Static.TOKEN};
    try {
      Response response = await dio!.get(endPoint!);
      print(response);
      return response;
    } catch (e) {
      print(e);
    }
  }

  static Future<Response?> postData(
      {@required String? endPoint,
      String? token,
      Map<dynamic, dynamic>? data}) async {
    try {
      print("enter to post");
      dio!.options.headers = {'Authorization': Static.TOKEN};
      Response response = await dio!.post(endPoint!, data: data);
      print(response);
      return response;
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<Response?> putData(
      {@required String? endPoint,
      @required Map<dynamic, dynamic>? data,
      String? token}) async {
    try {
      dio!.options.headers = {'Authorization': Static.TOKEN};
      Response response = await dio!.put(endPoint!, data: data);
      return response;
    } catch (e) {
      print(e);
    }
  }

  static Future<Response?> deleteData(
      {@required String? endPoint,
        @required Map<dynamic, dynamic>? data,
        String? token}) async {
    try {
      dio!.options.headers = {'Authorization': Static.TOKEN};
      Response response = await dio!.delete(endPoint!, data: data);
      return response;
    } catch (e) {
      print(e);
    }
  }

}
