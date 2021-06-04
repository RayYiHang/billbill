import 'package:billbill/http/core/hi_net_error.dart';
import 'package:billbill/util/toast.dart';
import 'package:billbill/util/util_string.dart';
import 'package:billbill/widget/app_bar.dart';
import 'package:billbill/widget/login_button.dart';
import 'package:billbill/widget/login_effect.dart';
import 'package:billbill/widget/login_input.dart';
import 'package:flutter/material.dart';
import 'package:billbill/http/dao/login_dao.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onJumpToRegister;
  const LoginPage({Key key, this.onJumpToRegister}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool protect = false;
  bool loginEnable = false;
  String userName;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('登录', '注册', widget.onJumpToRegister),
      body: Container(
        child: ListView(
          children: [
            LoginEffect(protect: protect),
            LoginInput('用户名', '请输入用户名', onChange: (text) {
              userName = text;
              checkInput();
            }),
            LoginInput('密码', '请输入密码',
              onChange: (text) {
                password = text;
                checkInput();
            }, obscureText: true,
              focusChange: (focus) {
              this.setState(() {
                protect = focus;
              });
            }),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: LoginButton("登录", enable:loginEnable, onPressed: send, onNotPressed: noLogin))
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool enable;
    if (isNotEmpty(userName) && isNotEmpty(password)) {
      enable = true;
    } else {
      enable = false;
    }
    this.setState(() {
      loginEnable = enable;
    });
  }

  void send() async {
    try {
      var result = await LoginDao.login(userName, password);
      print(result);
      if (result?.code == '0') {
        print('登录成功');
        showToast('登录成功');
      } else {
        print(result.data['msg']);
        showToast(result.data['msg']);
      }
    } on NeedAuth catch(e) {
      print(e);
      showToast(e.message);
    } on HiNetError catch(e) {
      print(e);
      showToast(e.message);
    }
  }

  void noLogin() {
    showToast('请输入值');
  }
}
