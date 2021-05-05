import 'package:billbill/http/request/base_request.dart';

import 'hi_net_adapter.dart';

// 适配mock adapter
class MockAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) {
    return Future<HiNetResponse>.delayed(Duration(milliseconds: 1000), () {
      return HiNetResponse(data:{"code":401, "message": 'success'}, statusCode: 403);
    });
  }

}