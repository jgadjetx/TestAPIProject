import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:all_posts/Models/DataProvider.dart';
import 'package:all_posts/Models/User.dart';
import 'package:all_posts/Widgets/UserCard.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  final String love = "Love";

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
        child: Users(),
      )  
    );
  }
}

class Users extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    final data = Provider.of<DataProvider>(context);

    return 
    Scaffold
    (
      body: 
      SafeArea
      (
        child: 
        Builder
        (
          builder: (context)=>
          Center
          (
            child: 
            FutureBuilder<List<User>>
            (
              future: data.getUsers(),
              builder: (context, snapshot)
              {
                if(snapshot.hasData){
                  return
                  ListView.builder
                  (
                    itemCount: snapshot.data.length,
                    itemBuilder: (context,index)
                    {
                      return
                      UserCard(snapshot.data[index]);
                    },
                  );
                }
                else{
                  return CircularProgressIndicator();
                }

              },
            )
          ),
        )
      )
    );
  }
}
