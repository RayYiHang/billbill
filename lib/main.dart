import 'dart:convert';

import 'package:billbill/db/hi_cache.dart';
import 'package:billbill/http/core/hi_net.dart';
import 'package:billbill/http/dao/login_dao.dart';
import 'package:billbill/http/request/test_request.dart';
import 'package:billbill/model/owner.dart';
import 'package:billbill/page/home_page.dart';
import 'package:billbill/page/login_page.dart';
import 'package:billbill/page/register_page.dart';
import 'package:billbill/page/video_detail_page.dart';
import 'package:billbill/util/color.dart';
import 'package:flutter/material.dart';
import 'package:billbill/model/video_model';

void main() {
  runApp(BiliApp());
}

class BiliApp extends StatefulWidget {
  const BiliApp({Key key}) : super(key: key);

  @override
  _BiliAppState createState() => _BiliAppState();
}

class _BiliAppState extends State<BiliApp> {
  BiliRouteDelegate _routeDelegate = BiliRouteDelegate();
  BiliRouteInformationParser _routeInformationParser = BiliRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    // 定义route
    var widget = Router(
      routeInformationParser: _routeInformationParser,
      routerDelegate: _routeDelegate,
      routeInformationProvider: PlatformRouteInformationProvider(
        initialRouteInformation: RouteInformation(location: '/')
      ),
    );
    return MaterialApp(
      home: widget,
    );
  }
}


class BiliRouteDelegate extends RouterDelegate<BiliRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BiliRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;
  
  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  List<MaterialPage> pages = [];
  VideoModel videoModel;
  BiliRoutePath path;
  @override
  Widget build(BuildContext context) {
    // 构建路由栈
    pages = [
      pageWrap(HomePage(onJumpToDetail: (videoModel) {
        this.videoModel = videoModel;
        notifyListeners();
      }
      )),
      if (videoModel != null) pageWrap(VideoDetailPage(videoModel))
    ];

    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(BiliRoutePath path) async {
    this.path = path;
  }
}

class BiliRouteInformationParser extends RouteInformationParser<BiliRoutePath> {
  @override
  Future<BiliRoutePath> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);
    print('uri:$uri');
    if (uri.pathSegments.length == 0) {
      return BiliRoutePath.home();
    }
      return BiliRoutePath.detail();
  }

}

class BiliRoutePath {
  final String location;

  BiliRoutePath.home() : location = '/';
  BiliRoutePath.detail() : location = '/detail';
}

pageWrap(Widget child) {
  return MaterialPage(child: child, key: ValueKey(child.hashCode));
}