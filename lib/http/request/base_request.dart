enum HttpMethod { GET, POST, DELETE }

abstract class BaseRequest {
  // curl -X GET "http://api.devio.org/uapi/test/test?requestPrams=11" -H "accept: */*"
  // curl -X GET "https://api.devio.org/uapi/test/test/1（1为路径参数）
  var pathParams;
  var useHttps = true;

  HttpMethod httpMethod();

  String authority() {
    return "api.devio.org";
  }
  String path();

  String url() {
    Uri uri;
    var pathStr = path();

    ///适配路径参数
    if (pathParams != null) {
      if (path().endsWith("/")) {
        pathStr = "${path()}$pathParams";
      } else {
        pathStr = "${path()}/$pathParams";
      }
    }
    /// http和https切换
    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }
    return uri.toString();
  }

  bool needLogin();

  ///添加请求参数
  Map<String, String> params = Map();
  BaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  //添加header
  Map<String, String> header = Map();
  BaseRequest addHeader(String k, String v) {
    header[k] = v.toString();
    return this;
  }
}