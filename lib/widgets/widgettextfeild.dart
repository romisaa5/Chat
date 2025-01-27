import 'package:flutter/material.dart';

class customformtextfield extends StatelessWidget {
  customformtextfield(
      {super.key,
      required this.hinttext,
      this.onchanged,
      this.obscuretext = false,required this.icon});
  final String hinttext;
  final Function(String)? onchanged;
  bool? obscuretext;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscuretext!,
      validator: (data) {
        if (data!.isEmpty) {
          return "field is requiered";
        }
      },
      onChanged: onchanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        labelText: hinttext,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        prefixIcon:icon
      
        
      
        ,
      ),
    );
  }
}
