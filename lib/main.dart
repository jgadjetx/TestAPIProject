import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:all_posts/Models/DataProvider.dart';
import 'package:all_posts/Screens/Users.dart';
import 'package:all_posts/Screens/Posts.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return 
    MaterialApp
    (
      debugShowCheckedModeBanner: false,
      home: 
      ChangeNotifierProvider<DataProvider>
      (
        builder: (context) => DataProvider(),
        child: Posts(),
      )  
    );
  }
}