import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:all_posts/Models/DataProvider.dart';
import 'package:all_posts/Screens/Posts.dart';
import 'Widgets/BigButton.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return 
    MaterialApp
    (
      debugShowCheckedModeBanner: false,
      home: 
      Scaffold
      (    
        body: 
        SafeArea
        (
          child: 
          ChangeNotifierProvider<DataProvider>
          (
            builder: (context) => DataProvider(),
            child: Posts()
          )
        )
      )  
    );
  }
}