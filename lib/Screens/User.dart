import 'package:all_posts/Models/ThumbnailAndTitle.dart';
import 'package:all_posts/Widgets/ThumbnailAndTitleWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:all_posts/Models/DataProvider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:all_posts/Models/User.dart';

class Users extends StatelessWidget{


  final int userID;
  Users(this.userID);

  
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
            FutureBuilder<User>
            (
              future: data.getUser(this.userID),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return
                  (
                    Padding
                    (
                      padding: EdgeInsets.all(20),
                      child: 
                      Column
                      (
                        children: <Widget>
                        [
                          Row
                          (
                            children: <Widget>
                            [
                              Icon(MdiIcons.account,size: 30),
                              Text(snapshot.data.name, style: TextStyle(fontSize: 20))
                            ],
                          ),
                          Row
                          (
                            children: <Widget>
                            [
                              Icon(MdiIcons.web,size: 30),
                              Text(snapshot.data.website, style: TextStyle(fontSize: 20)),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row
                          (
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>
                            [
                              Text("Albums",style: TextStyle(fontSize: 20)),
                            ],
                          ),       
                          SizedBox(height: 20),
                          Flexible
                          (
                            child: 
                            FutureBuilder<List<ThumbnailAndTitle>>
                            (
                              future: data.getUserThumbnail(this.userID),
                              builder: (context, snapshot){
                                if(snapshot.hasData){
                                  return
                                  GridView.builder
                                  (
                                    itemCount: snapshot.data.length,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                                    itemBuilder: (context, index){
                                      return
                                      ThumbnailAndTitleWidget(snapshot.data[index].getTitle, snapshot.data[index].getThumbnailUrl);
                                    },
                                  );
                                }
                                else{
                                  return
                                  CircularProgressIndicator();
                                }
                              }
                            )
                          )                     
                        ],
                      )
                    )                
                  );
                }
                else{
                  return
                  CircularProgressIndicator();
                }
              }

            )
          ),
        )
      )
    );
  }
}
