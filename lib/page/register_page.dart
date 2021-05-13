import 'package:billbill/widget/app_bar.dart';
import 'package:billbill/widget/login_effect.dart';
import 'package:billbill/widget/login_input.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {

  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool protect = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: appBar('注册', '登录', () => {
        print('点击了右键')
      }),
      body: ListView(
        children: [
          LoginEffect(protect: protect),
          LoginInput(
            '用户名',
            '请输入用户名',
            onChange: (text) => {print('用户名输入了：$text')},
            focusChange: (change) => {print(change)},
          ),
          LoginInput(
            '密码',
            '请输入密码',
            obscureText: true,
            onChange: (text) => {print('密码输入了：$text')},
            focusChange: (change) => {this.setState(() {
              protect = change;
            })},
          )
        ],
      ),
    );
  }
}
