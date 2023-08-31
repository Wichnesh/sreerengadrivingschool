import 'dart:async';

import 'package:dio/dio.dart';

class RequestDio {
  final String? url;
  final dynamic body;
  final Dio dio = Dio();

  RequestDio({this.url, this.body}) {
    dio.options.headers['Accept'] = 'application/json';
  }

  Future<Response<dynamic>> post() async {
    try {
      final response = await dio.post(url!, data: body);
      return response;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        throw TimeoutException('Connection timeout. Please try again.');
      } else {
        print(e.toString());
        throw Exception('Error occurred while making a request.');
      }
    }
  }

  Future<Response<dynamic>> get() async {
    try {
      final response = await dio.get(url!, data: body);
      return response;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        throw TimeoutException('Connection timeout. Please try again.');
      } else {
        print(e.toString());
        throw Exception('Error occurred while making a request.');
      }
    }
  }

  Future<Response<dynamic>> put() async {
    try {
      final response = await dio.put(url!, data: body);
      return response;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        throw TimeoutException('Connection timeout. Please try again.');
      } else {
        print(e.toString());
        throw Exception('Error occurred while making a request.');
      }
    }
  }
}
