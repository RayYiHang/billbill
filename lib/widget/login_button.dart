import 'package:billbill/util/color.dart';
import 'package:billbill/util/toast.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String title;
  final bool enable;
  final VoidCallback onPressed;
  final VoidCallback onNotPressed;

  const LoginButton(this.title,{Key key, this.enable=true, this.onPressed, this.onNotPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: MaterialButton(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        height: 45,
        onPressed: enable ? onPressed :onNotPressed,
        // disabledColor: Colors.grey,
        color: enable ? primary : Colors.grey,
         child: Text(title, style: TextStyle(color: Colors.white, fontSize: 16),),
      ),
    );
  }
}
