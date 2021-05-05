import 'package:billbill/http/core/hi_net_adapter.dart';
import 'package:billbill/http/core/hi_net_error.dart';
import 'package:billbill/http/request/base_request.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/// Dio适配器
class DioAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
    var response, options = Options(headers: request.header);
    var error;
    try {
      if (request.httpMethod() == HttpMethod.GET) {
        response = await Dio().get(request.url(),options: options);
      } else if (request.httpMethod() == HttpMethod.POST) {
        response = await Dio().post(request.url(),data: request.params,options: options);
      } else if (request.httpMethod() == HttpMethod.DELETE) {
        response = await Dio().delete(request.url(),data: request.params,options: options);
      }
    } on DioError catch(e) {
      error = e;
      print('e$e');
      response = e.response;
    }
    if (error != null) {
      ///抛出hi_net_error
      throw HiNetError(response ?.statusCode ?? -1, error.toString(),
          data: buildRes(response, request));
    }
    return buildRes(response, request);
  }

  HiNetResponse buildRes(Response response, BaseRequest request) {
    return HiNetResponse(
      data: response.data,
      request: request,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      extra: response
    );
  }

}