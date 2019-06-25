import 'package:flutter/material.dart';


class ThumbnailAndTitleWidget extends StatelessWidget{

  final String albumName; 
  final String thumbnailUrl;

  ThumbnailAndTitleWidget(this.albumName, this.thumbnailUrl);

  @override
  Widget build(BuildContext context) {

    return 
    Column
    (
      children: <Widget>
      [
        Container
        (

          width: 200,
          height: 180,
          child: 
          Column
          (
            children: <Widget>
            [
              Container
              (
                width: 150,
                height: 150,
                child: Image.network(thumbnailUrl),
              ),
              Text(albumName, overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 15))     
            ],
          )
        )
        
      ],
    );
  }
}