import 'package:flutter/material.dart';
import '../constans.dart';

class CustomBottom extends StatelessWidget {
   CustomBottom({this.onTap,required this.text});
  VoidCallback? onTap ;
  String? text ;
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap:onTap ,
      child: Container(
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            text!,
            style:const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color:  Color(0xff2B475E)
            ),
          ),
        ),
      ),
    );
  }
}
