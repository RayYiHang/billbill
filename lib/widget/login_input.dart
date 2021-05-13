import 'package:billbill/util/color.dart';
import 'package:flutter/material.dart';

/// 自定义登录输入框
class LoginInput extends StatefulWidget {
  final String title;
  final String hint;
  final ValueChanged<String> onChange; //回调
  final ValueChanged<bool> focusChange; //回调
  final bool lineStretch;
  final bool obscureText;
  final TextInputType keyboardType;

  const LoginInput(this.title, this.hint,
      {Key key,
      this.onChange,
      this.focusChange,
      this.lineStretch = false,
      this.obscureText = false,
      this.keyboardType})
      : super(key: key);

  @override
  _LoginInputState createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  final _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      print("Has focus: ${_focusNode.hasFocus}");
      if (widget.focusChange != null) {
        widget.focusChange(_focusNode.hasFocus);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 15),
                  width: 100,
                  child: Text(
                    widget.title,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                _input()
              ],
            ),
            Padding(padding: EdgeInsets.only(left: !widget.lineStretch ? 15 : 0),
            child: Divider(
              height: 1,
              thickness: 0.5,
            ),
            )
          ],
        )
    );
  }

  _input() {
    return Expanded(
      child: TextField(
        focusNode: _focusNode,
        onChanged: widget.onChange,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        autofocus: !widget.obscureText,
        cursorColor: primary,
        style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w300), //输入文字颜色
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 20, right: 20),
            border: InputBorder.none,
            hintText: widget.hint ?? "",
            hintStyle: TextStyle(fontSize: 15, color: Colors.grey)),
      ),
    );
  }
}
