import 'package:flutter/material.dart';


class custombutton extends StatelessWidget {
  const custombutton({super.key, this.ontab, required this.text});
  final String text;
  final VoidCallback? ontab;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontab,
      child: Container(
        height: 47,
        width: 170,
        
        decoration: BoxDecoration(
          
          color: Color.fromARGB(255, 200, 184, 229),
          borderRadius: BorderRadius.all(Radius.circular(27)),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 17, color: Colors.grey[850]),
          ),
        ),
      ),
    );
  }
}
