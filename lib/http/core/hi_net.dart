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
    var response = await send(request);
    var result = response['data'];
    print(result);
    return result;
  }
  
  Future<dynamic> send<T>(BaseRequest request) async {
    printLog(request.httpMethod());
    request.addHeader('token', 'jkwehdo2j9823ndlkwjnwodi');
    printLog(request.header);
    printLog(request.params);
    printLog(request.url());
    return Future.value({
      "statusCode": 200,
      "data":{
        "code":0,
        "message":"success"
      }
    });
  }
  
  void printLog(msg) {
    print("hi_net:${msg.toString()}");
  }
}