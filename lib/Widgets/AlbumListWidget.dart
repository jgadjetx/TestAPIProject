import 'package:flutter/material.dart';
import 'package:all_posts/Models/DataProvider.dart';
import 'package:provider/provider.dart';
import 'package:all_posts/Models/Album.dart';
import 'package:all_posts/Models/User.dart';
import 'ThumbnailAndTitle.dart';

class AlbumListWidget extends StatelessWidget{

  final User user;
  AlbumListWidget(this.user);

  @override
  Widget build(BuildContext context) {

    final data = Provider.of<DataProvider>(context);

    return 
    FutureBuilder<List<Album>>
    (
      future: data.getAlbums(this.user.id),
      builder: (context, snapshot)
      {
        if(snapshot.hasData){
          return
          ListView.builder
          (
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data.length,
            itemBuilder: (context,index)
            {
              return
              ThumbnailAndTitle(snapshot.data[index]);
            },
          );
          
        }
        else{
          return
          Text("Loading...");
        }
      }
    );
  }
}

