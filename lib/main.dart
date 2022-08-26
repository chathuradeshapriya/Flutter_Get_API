import 'package:api_tutorial/example_four.dart';
import 'package:api_tutorial/example_two.dart';
import 'package:api_tutorial/homescreen.dart';
import 'package:api_tutorial/sign_up.dart';
import 'package:api_tutorial/upload_image.dart';
import 'package:flutter/material.dart';

import 'example_five.dart';
import 'example_three.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:  UploadImage(),
    );
  }
}
