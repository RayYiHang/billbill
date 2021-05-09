import 'package:billbill/http/core/dio_adapter.dart';
import 'package:billbill/http/core/hi_net_adapter.dart';
import 'package:billbill/http/core/hi_net_error.dart';
import 'package:billbill/http/core/http_adapter.dart';
import 'package:billbill/http/core/mock_adapter.dart';
import 'package:billbill/http/request/base_request.dart';

class HiNet {
  ///单例模式
  //私有构造函数
  HiNet._();

  //私有静态实例
  static HiNet _instance;

  //静态生成实例方法
  static HiNet getInstance() {
    if (_instance == null) {
      _instance = HiNet._();
    }
    return _instance;
  }

  Future fire(BaseRequest request) async {
   HiNetResponse response;
   var error;
   try {
     response = await send(request);
   } on HiNetError catch(e) {
     error = e;
     response = e.data;
     printLog(e.message);
   } catch(e) {
     // 其他异常
     printLog(e);
   }

   if (response == null) {
     printLog(error);
   }

   var result = response.data;
   printLog("response.data$result");
   var status = response.statusCode;
   switch(status) {
     case 200:
       return result;
       break;
     case 401:
       return NeedLogin();
       break;
     case 403:
       return NeedAuth(result.toString(),data: result);
   }
  }
  
  Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
    return await DioAdapter().send(request);
  }
  
  void printLog(msg) {
    print("hi_net:${msg.toString()}");
  }
}