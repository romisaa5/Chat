
  import 'package:flutter/material.dart';

void showsnackbar(BuildContext context, String massege) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(massege)),
    );
  }