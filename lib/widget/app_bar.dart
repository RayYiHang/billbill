import 'package:flutter/material.dart';

///自定义顶部appbar
appBar(String title,String rightTitle, VoidCallback rightButtonClick) {
  return AppBar(
    //让title居左

    centerTitle: true,
    elevation: 0, //去除阴影
    titleSpacing: 0,
    leading: BackButton(color: Colors.grey[500]),
    title: Text(
      title,
      style: TextStyle(fontSize: 19),
    ),
    actions: [
      InkWell(
        onTap: rightButtonClick,
        child: Container(
          padding: EdgeInsets.only(left: 10,right: 20),
          alignment: Alignment.center,
          child: Text(
            rightTitle,
            style: TextStyle(fontSize: 15, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ),
      )
    ],
  );
}