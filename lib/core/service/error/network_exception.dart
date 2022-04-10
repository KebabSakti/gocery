import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gocery/core/service/error/base_exception.dart';
import 'package:gocery/core/service/error/business_exception.dart';

class NetworkException extends BaseException {
  NetworkException(DioError exception, StackTrace stackTrace)
      : super(exception, stackTrace) {
    if (exception.response == null) {
      throw NoInternet();
    }

    switch (exception.response!.statusCode) {
      case 400:
        var parsed = jsonDecode(exception.response!.data);

        if (parsed['message'] == 'OUT_OF_STOCK') {
          throw OutOfStock();
        }

        throw ServerError();

      case 401:
        throw Unauthenticated();

      default:
        throw ServerError();
    }
  }
}

class Unauthenticated implements Exception {}

class ServerError implements Exception {}

class NoInternet implements Exception {}
