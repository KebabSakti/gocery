import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:dio/adapter.dart';
import 'package:get/get.dart';
import 'package:gocery/core/config/app_const.dart';
import 'package:gocery/core/service/network/network.dart';
import 'package:gocery/core/service/storage/storage.dart';

class DioClient implements Network {
  static final dio.Dio _dio = dio.Dio();

  //do client network config, async, await, init, bearer token etc in here
  @override
  Future<Network> init() async {
    //access secure local storage for authorization token
    final SecureStorageImpl _sBox = Get.find();

    //authorization token
    final String? token = await _sBox.read(key: 'token');

    //network client configuration
    _dio.options.baseUrl = '$kProtocol://$kBaseUrl/api/v1/';
    _dio.options.connectTimeout = kNetworkConnectTimeout;
    _dio.options.receiveTimeout = kNetworkReceiveTimeout;
    _dio.options.responseType = dio.ResponseType.plain;

    //default header for all request
    _dio.options.headers = {
      'content-type': 'application/json',
    };

    //add authorization token to header
    if (token != null) {
      _dio.options.headers['authorization'] = 'Bearer $token';
    }

    if (kNetworkLog) {
      //log all network request to console (development only)
      _dio.interceptors.add(dio.LogInterceptor(responseBody: false));
    }

    if (kProxy) {
      //proxy all connection to host:port for request/response logging (development only)
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.findProxy = (uri) {
          return "PROXY $kProxyUrl";
        };
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }

    return this;
  }

  @override
  Future get(String path, {Map<String, String?>? query}) async {
    return await _dio.get(path, queryParameters: query);
  }

  @override
  Future post(String path, {required Map<String, String?>? data}) async {
    return await _dio.post(path, data: data);
  }

  @override
  Future download(String path, {String? savePath}) async {
    return await _dio.download(path, savePath);
  }

  @override
  Future upload(String path, {required formData}) async {
    return await _dio.post(path, data: formData);
  }
}
