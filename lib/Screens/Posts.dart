import 'package:all_posts/Widgets/PostCardWithComments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:all_posts/Models/DataProvider.dart';
import 'package:all_posts/Widgets/PostCard.dart';
import 'package:all_posts/Models/Post.dart';
import 'package:provider/provider.dart';

class Posts extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    
    return 
    _Posts();
  }

}

class _Posts extends State<Posts>{

  bool showComments = false;
  bool nextButton = false;
  bool prevButton = false;
  

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
          (
            Center
            (
              child: 
              Column
              (
                children: <Widget>
                [
                  Row
                  (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>
                    [
                      
                      RaisedButton
                      (
                        
                        child: Text("Prev Post"),
                        onPressed: data.getPage == 1 ? null : ()=> data.prevPage()
                      ),
                      SizedBox
                      (
                        width: 22,
                      ),
                      Text("Show Comments"),
                      Switch
                      (
                        value: showComments,
                        onChanged: (value){

                          setState(() {
                            showComments = value; 
                            print("Show Status: " + value.toString());
                          });

                        },
                        activeTrackColor: Colors.lightGreenAccent, 
                        activeColor: Colors.green,
                      ),
                      SizedBox
                      (
                        width: 22,
                      ),
                      RaisedButton
                      (
                        child: Text("Next Post"),
                        onPressed: !data.hasNextPage ? null : ()=> data.nextPage()
                      ),
                    ],
                  ), 
                  Flexible
                  (
                    child: 
                    FutureBuilder<List<Post>>
                    (
                      future: data.getPosts(),
                      builder: (context,snapshot)
                      {

                        if(snapshot.hasData){
                          return
                          ListView.builder
                          (
                            itemCount: snapshot.data.length,
                            itemBuilder: (context,index){

                              if(showComments){
                                return
                                PostCardWithComments(snapshot.data[index]);
                              }
                              else{
                                return
                                PostCard(snapshot.data[index]);
                              }
                              
                            },
                          );
                        }
                        else
                        {
                          return
                          Text("");
                        }
                      }
                    )
                  ),   
                ],
              )
            )
          )          
        )
      ),
    );
    
  }
}
