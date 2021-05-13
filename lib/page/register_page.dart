import 'package:billbill/http/core/hi_net_error.dart';
import 'package:billbill/http/dao/login_dao.dart';
import 'package:billbill/util/util_string.dart';
import 'package:billbill/widget/app_bar.dart';
import 'package:billbill/widget/login_effect.dart';
import 'package:billbill/widget/login_input.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback onJumpToLogin;
  const RegisterPage({Key key, this.onJumpToLogin}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool protect = false;
  bool loginEnable = false;
  String userName;
  String password;
  String rePassword;
  String immocId;
  String orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: appBar('注册', '登录', widget.onJumpToLogin),
      body: ListView(
        children: [
        LoginEffect(protect: protect),
        LoginInput(
          "用户名",
          "请输入用户名",
          onChange: (text) {
            userName = text;
            checkInput();
          },
        ),
          LoginInput(
            "密码",
            "请输入密码",
            obscureText: true,
            onChange: (text) {
              password = text;
              checkInput();
            },
            focusChange: (focus) {
              this.setState(() {
                protect = focus;
              });
            },
          ),
          LoginInput(
            '确认密码',
            '请再次输入密码',
            onChange: (text) {
              rePassword = text;
              checkInput();
            },
            focusChange: (focus) {
              this.setState(() {
              protect = focus;
            });
            },
          ),
          LoginInput(
            '慕课网ID',
            '请输入你的慕课网用户ID',
            keyboardType: TextInputType.number,
            onChange: (text) {
              immocId = text;
              checkInput();
            },
          ),
          LoginInput(
            '课程订单号',
            '请输入课程订单号后四位',
            keyboardType: TextInputType.number,
            lineStretch: true,
            onChange: (text) {
              orderId = text;
              checkInput();
            },
          ),
          Padding(
              padding: EdgeInsets.only(top: 20,left: 20, right: 20),
              child: _loginButton()
          )
        ],
      ),
    );
  }

  void checkInput() {
    bool enable;
    if (isNotEmpty(userName) &&
        isNotEmpty(password) &&
        isNotEmpty(rePassword) &&
        isNotEmpty(immocId) &&
        isNotEmpty(orderId)) {
      enable = true;
    } else {
      enable = false;
    }
    this.setState(() {
      loginEnable = enable;
    });
  }

  _loginButton() {
    return InkWell(
        onTap: () {
          if (loginEnable) {
            checkParams();
          } else {
            print('loginEnable is false');
          }
        },
        child: Text('登录'),
    );
  }

  void checkParams() {
    String tips;
    if (password != rePassword) {
      tips = "两次密码输入不一致，请重新输入";
    } else if (orderId.length != 4){
      tips = "请输入订单号的后四位";
    }
    if (tips != null) {
      print(tips);
      return;
    }
    send();
  }

  void send() async {
    try {
      var result = await LoginDao.register(userName, password, immocId, orderId);
      print(result);
      if (result?.code == '0') {
        print('注册成功');
        if (widget.onJumpToLogin != null) {
          widget.onJumpToLogin();
        }
      } else {
        print(result.data['msg']);
      }
    } on NeedAuth catch(e) {
      print(e);
    } on HiNetError catch(e) {
      print(e);
    }
  }
}
