import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import '../presets/api_paths.dart';
import '../presets/token.dart';

class MyDio {
  static String baseUrl = ApiPaths.baseUrl;

  late Dio _dio;

  MyDio() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 60),
      // 30 seconds
      receiveTimeout: const Duration(seconds: 120),
      // 60 seconds

      responseType: ResponseType.plain,
      headers: {
        Headers.contentTypeHeader: "application/json",
        if (Token.accessToken.isNotEmpty) "Authorization": "Bearer ${Token
            .accessToken}",
      },
    );

    _dio = Dio(options);
    //_dio.interceptors.add(LogInterceptor());
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final HttpClient client =
      HttpClient(context: SecurityContext(withTrustedRoots: false));
      client.badCertificateCallback = (cert, host, port) => true;
      return client;
    };
    _dio.interceptors.add(
      InterceptorsWrapper(onError: (ex, error) {
      }),
    );
// HTTPS certificate verification (or public key pinning) refers to the process
// of ensuring that the certificates protecting the TLS connection to
// the server are the ones you expect them to be.
// The intention is to reduce the chance of a man-in-the-middle attack.
  }
  Future<dynamic> get(String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceivedProgress,
  }) async {
    try {
      Response resp = await _dio.get(baseUrl + path,
          queryParameters: queryParameters,
          data: data,
          options: Options(responseType: ResponseType.plain, headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Token.accessToken}"
          }));
      log("!!!!!!!!!!!!!! Request Begin !!!!!!!!!!!!!!!!!!!!!");
      log(
          "REQUEST[${resp.statusCode}] => PATH: ${resp.requestOptions.path}");
      log("ResMethodType : [${resp.requestOptions.method}]");
      resp.requestOptions.headers.forEach((k, v) => log('$k: $v'));

      log("QueryParameters:");
      resp.requestOptions.queryParameters
          .forEach((k, v) => log('$k: $v'));
      log(resp.requestOptions.queryParameters.toString());

      if (resp.requestOptions.data != null) {
        log("Body: ${jsonEncode(resp.requestOptions.data)}");
      }
      log('resp >>>${resp.data}');
      log("************** Response End ************************");
      dynamic apiResp;
      if (resp.data
          .toString()
          .isNotEmpty) {
        apiResp = resp.data;
      }
      return apiResp;
    } on DioException catch (e) {
      log("!!!!!!!!!!!!!! Error Begin !!!!!!!!!!!!!!!!!!!!!");
      log(
          "REQUEST[${e.response?.statusCode}] => PATH: ${e.requestOptions
              .path}");
      log("ResMethodType : [${e.requestOptions.method}]");
      e.requestOptions.headers.forEach((k, v) => log('$k: $v'));

      log("QueryParameters:");
      e.requestOptions.queryParameters.forEach((k, v) => log('$k: $v'));
      log(e.requestOptions.queryParameters.toString());

      if (e.requestOptions.data != null) {
        log("Body: ${jsonEncode(e.requestOptions.data)}");
      }
      log("************** Error End ************************");
      if (e.type == DioExceptionType.badResponse) {
        // ignore: avoid_print
        print(path);
        throw Exception('No proper response from server');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timed-out. Check internet connection.');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Unable to connect to the server');
      }
      if (e.type == DioExceptionType.unknown) {
        throw Exception('Something went wrong with server communication');
      }
      if (e.response?.statusCode == 406) {
        if (kDebugMode) {
          print(e.response?.statusCode);
          print(e.response.toString());
        }
      }
      log(e.toString());
      throw Exception(e.toString());
    }
  }
}