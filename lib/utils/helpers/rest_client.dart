import 'dart:async';
import 'package:acceptwire/exceptions/RequestResponseException.dart';
import 'package:acceptwire/repository/auth_repository.dart';
import "package:dio/dio.dart";
import 'package:get/get.dart' as gt;

class RequestResponse<T> {
  static const STATUS_SUCCESS = "success";
  static const STATUS_FAIL = "failed";
  static const STATUS_OK = 200;

  String? status;
  int? statusCode;

  var data;
  String? reason;

  //T data;

  RequestResponse._({this.status, this.statusCode, this.data, this.reason});

  factory RequestResponse.fromJson(Map<String, dynamic> json) {
    // if (json['statusCode'] != 200) {
    //   throw RequestResponseException(
    //       cause: json.containsKey('message')
    //           ? "${json['statusCode']} json['message']"
    //           : 'Unmarked error occurred: ${json['statusCode']} ');
    // }
    return new RequestResponse._(
      status: 'success',
      statusCode: json['statusCode'],
      data: json['data'],
      reason: json['message'],
    );
  }
}

class Error422 {
  String? message;
  List? errors = [];

  Error422({
    this.message,
    this.errors,
  });

  factory Error422.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> m = json['errors'];
    return new Error422(
      message: json['message'],
      errors: m.entries.map((entry) => entry.value[0]).toList(),
    );
  }
}

class RestClientRepository {
  String api = 'https://ofwy0c5ku9.execute-api.eu-central-1.amazonaws.com/dev';

  final AuthRepository authRepo;

  RestClientRepository({required this.authRepo});

  Dio init() {
    Dio _dio = new Dio();
    _dio.interceptors.add(new ApiInterceptors(authRepo: authRepo));
    _dio.options.baseUrl = "$api";
    return _dio;
  }
}

class ApiInterceptors extends Interceptor {
  final AuthRepository authRepo;

  ApiInterceptors({required this.authRepo});

  //String authToken;

  /// get auth token if empty
  /// return auth token

  /// intercept all requests
  /// set necessary headers
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['Content-type'] = 'application/json';
    options.headers['Accept'] = 'application/json';
    options.headers['Authorization'] = '${await authRepo.getToken()}';

    // print('${await authRepo.getToken()}');
    // do something before request is sent
    return super.onRequest(options, handler);
  }

  @override
  onError(DioError dioError, ErrorInterceptorHandler handler) {
    String errorString;

    if (!gt.GetUtils.isNullOrBlank(dioError.response)!) {
      if (dioError.response!.statusCode == 422) {
        errorString = 'Input validation error: 422';
      } else if (dioError.response!.statusCode == 400) {
        errorString = 'Bad request: 400 ';
      } else if (dioError.response!.statusCode == 403) {
        errorString = 'UnAuth request: 403 ';
      } else if (dioError.response!.statusCode == 401) {
        errorString = 'You are not authorised to perform this action: 401';
      } else if (dioError.response!.statusCode == 500) {
        errorString = 'An internal error occurred: 500';
      } else if (dioError.response!.statusCode == 404) {
        errorString = 'An internal error occurred: 404';
      } else {
        errorString = 'An error occurred completing your request, ';
      }
    } else {
      errorString = 'Please check your internet and try again';
      // call  bugsnag.
    }

    if (gt.GetUtils.isNullOrBlank(dioError.response) ?? true) {
      dioError.error = RequestResponse._(
          status: 'failed', statusCode: 0, reason: 'Error: $errorString');
    } else {
      dioError.error = RequestResponse._(
          status: 'failed',
          statusCode: dioError.response!.statusCode,
          reason: 'Error: $errorString');
    }

    return super.onError(dioError, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    response.data = RequestResponse.fromJson(response.data);
    return super.onResponse(response, handler);
  }
}
