import 'package:flutter/material.dart';
import 'package:grid_app/authentication.dart';
// import 'package:flutter/widgets.dart';
// import 'package:grid_app/login.dart';
// import 'package:grid_app/signup.dart';
// import 'package:grid_app/gridpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AuthApp(), // Set LoginPage as the initial screen
    );
  }
}