import 'package:all_posts/Models/Photo.dart';
import 'package:flutter/material.dart';
import 'package:all_posts/Models/Album.dart';
import 'package:all_posts/Models/DataProvider.dart';
import 'package:provider/provider.dart';

class ThumbnailAndTitle extends StatelessWidget{

  final Album album; 
  ThumbnailAndTitle(this.album);

  @override
  Widget build(BuildContext context) {

    final data = Provider.of<DataProvider>(context);

    return 
    FutureBuilder<List<Photo>>
    (
      future: data.getThumbnail(),
      builder: (context,snapshot){

        if(snapshot.hasData){
          return
          Container
          (
            margin: EdgeInsets.only(right: 5,top: 5),
            width: 100,
            height: 150,
            child: 
            Column
            (
              children: <Widget>
              [
                Image.network
                (
                  snapshot.data[album.id-1].thumbnailUrl,
                  width: 100,
                  height: 100,
                ),
                Text
                (
                  album.title,        
                )
              ],
            )
          );
        }
        else{
          return
          Text("");
        }
      },
    );
  }
}