import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:all_posts/Models/DataProvider.dart';
import 'package:all_posts/Screens/Users.dart';
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
          Builder
          (
            builder:(context)=>
            Center
            (
              child: 
              Column
              (

                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>
                [
                  BigButton
                  (
                    text: "Posts",
                    onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context){
                        return
                        ChangeNotifierProvider<DataProvider>
                        (
                          builder: (context) => DataProvider(),
                          child: Posts()
                        );
                        
                      } ));
                    }
                  ),
                  BigButton
                  (
                    text: "Users",
                    onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context){
                        return
                        ChangeNotifierProvider<DataProvider>
                        (
                          builder: (context) => DataProvider(),
                          child: Users()
                        );
                        
                      } ));
                    }
                  ),
                ],
              )
            )
          )
          
        )
      )  
    );
  }
}