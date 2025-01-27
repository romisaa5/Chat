import 'package:flutter/material.dart';
import 'package:frist/models/messages.dart';

class chatbubble extends StatelessWidget {
 const chatbubble({
    super.key,required this.massege
  });
    final Message massege;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(top: 22, bottom: 22, left: 18, right: 25),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomRight: Radius.circular(32)),
          color: Color.fromARGB(255, 144, 105, 151),
        ),
        child: Text(
         massege.message,
          style: TextStyle(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class chatbubbleforfriend extends StatelessWidget {
 const chatbubbleforfriend({
    super.key,required this.massege
  });
    final Message massege;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.only(top: 22, bottom: 22, left: 18, right: 25),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomLeft: Radius.circular(32)),
          color: Color.fromARGB(255, 146, 141, 147),
        ),
        child: Text(
         massege.message,
          style: TextStyle(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

