import 'dart:async';
import "package:dio/dio.dart";
import 'package:get/get.dart' as gt;

class RequestResponse<T> {
  static const STATUS_SUCCESS = "success";
  static const STATUS_FAIL = "failed";

  String? status;

  var data;
  String? reason;

  //T data;

  RequestResponse._({this.status, this.data, this.reason});

  factory RequestResponse.fromJson(Map<String, dynamic> json) {
    return new RequestResponse._(
      status: json['status'],
      data: json['data'],
      reason: json['reason'],
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
  String api = 'https://gc6y128zga.execute-api.eu-central-1.amazonaws.com/dev';

  Dio init() {
    Dio _dio = new Dio();
    _dio.interceptors.add(new ApiInterceptors());
    _dio.options.baseUrl = "$api";
    return _dio;
  }
}

class ApiInterceptors extends Interceptor {
  //String authToken;

  /// get auth token if empty
  /// return auth token

  /// intercept all requests
  /// set necessary headers
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // print(await this.getAuth());
    options.headers['Content-type'] = 'application/json';
    options.headers['Accept'] = 'application/json';
    // options.headers['Authorization'] = 'Bearer ${await this.getAuth()}';

    // do something before request is sent
    return super.onRequest(options, handler);
  }

  @override
  onError(DioError dioError, ErrorInterceptorHandler handler) {
    String errorString;

    if (!gt.GetUtils.isNullOrBlank(dioError.response)!) {
      if (dioError.response!.statusCode == 422) {
        errorString = 'Input validation error ';
        // Error422 err422 = Error422.fromJson(dioError.response!.data);
      } else if (dioError.response!.statusCode == 401) {
        errorString = 'You are not authorised to perform this action';
      } else if (dioError.response!.statusCode == 500) {
        errorString = 'An internal error occurred';
      } else if (dioError.response!.statusCode == 404) {
        errorString = 'An internal error occurred';
      } else {
        errorString = 'An error occurred completing your request, ';
      }
    } else {
      errorString = 'Please check your internet and try again';
      // call  bugsnag.
    }


    dioError.error =
        RequestResponse._(status: 'failed', reason: 'Error: $errorString');

    return super.onError(dioError, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    response.data = RequestResponse.fromJson(response.data);
    return super.onResponse(response, handler);
  }
}
