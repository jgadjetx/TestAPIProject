import 'package:flutter/material.dart';
import 'package:all_posts/Screens/Users.dart';
import 'package:all_posts/Screens/Posts.dart';
import 'package:provider/provider.dart';
import 'package:all_posts/Models/DataProvider.dart';

class Menu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return 
    Scaffold
    (
      body: 
      SafeArea
      (
        child: 
        Center
        (
          child: 
          Column
          (
            children: <Widget>
            [
              RaisedButton
              (
                child: Text("Users"),
                onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => Users()));
                },
              ),
              RaisedButton
              (
                child: Text("Posts"),
                onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => Posts()));
                },
              )
            ],
          )
        )
      )
    );
  }
}