import 'package:flutter/material.dart';
import 'package:scholor_chat/models/MassageModeal.dart';

import '../constans.dart';

class CustomMassageFrinedChat extends StatelessWidget {
  CustomMassageFrinedChat({required this.massage});
  final MassageModel? massage ;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 5,
            top: 5
        ),
        padding: EdgeInsets.all(20),
        decoration: const BoxDecoration(
            color: Color(0XFF6a9fd5),
            borderRadius:  BorderRadius.only(
              bottomRight: Radius.circular(55),
              topLeft: Radius.circular(55),
              bottomLeft: Radius.circular(55),
            )
        ),
        child: Text(
          '${massage!.Massage}',
          style: const TextStyle(
              color: Colors.white
          ),
        ),
      ),
    );
  }
}
