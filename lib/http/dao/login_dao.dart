import 'package:billbill/db/hi_cache.dart';
import 'package:billbill/http/core/hi_net.dart';
import 'package:billbill/http/request/base_request.dart';
import 'package:billbill/http/request/login_request.dart';
import 'package:billbill/http/request/register_request.dart';

class LoginDao {
  static const BOARDING_PASS = 'boarding-pass';
  static login(String userName, String password) {
    return _send(userName, password);
  }

  static register(String userName, String password, String immocId, String orderId) {
    return _send(userName, password, immocId: immocId, orderId: orderId);
  }

  static _send(String userName, String password, {String immocId, String orderId})  async {
    BaseRequest request;
    if (immocId != null && orderId != null) {
      request = RegisterRequest();
    } else {
      request = LoginRequest();
    }
    request
        .add('userName', userName)
        .add('password', password)
        .add('immocId', immocId)
        .add('orderId', orderId);
    var result = await HiNet.getInstance().fire(request);
    if(result.code == 0&&result.data != null) {
      HiCache.getInstance().setString(BOARDING_PASS, result.data);
    }
    print(result);
    return result;
  }
  static getBoardingPass() {
      return HiCache.getInstance().get(BOARDING_PASS);
  }
}
