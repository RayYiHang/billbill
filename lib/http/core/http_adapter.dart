import 'package:billbill/http/core/hi_net_adapter.dart';
import 'package:billbill/http/request/base_request.dart';
import 'package:http/http.dart' as http;

import 'hi_net_error.dart';
///http adapter
class HttpAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
    var response, error;
    try {
      if (request.httpMethod() == HttpMethod.GET) {
        response = await http.get(request.url(),headers: request.header);
        print(request.url());
      } else if (request.httpMethod() == HttpMethod.POST) {
        response = await http.post(
            request.url(), headers: request.header, body: request.params);
      } else if (request.httpMethod() == HttpMethod.DELETE) {
        response = await  http.delete(request.url(), headers: request.header);
      }
    } on http.ClientException catch(e) {
      error = e;
      print("e${e.message}");
    }

    if (error != null) {
      ///抛出hi_net_error
      throw HiNetError(response ?.statusCode ?? -1, error.toString(),
          data: buildRes(response, request));
    }
    return buildRes(response, request);
  }

  HiNetResponse buildRes(http.Response response, BaseRequest request) {
    return HiNetResponse(
        data: response.body,
        request: request,
        statusCode: response.statusCode,
        statusMessage: response.reasonPhrase,
        extra: response
    );
  }
}