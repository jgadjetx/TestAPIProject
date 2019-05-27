import 'package:flutter/material.dart';
import 'package:all_posts/Models/User.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class UserCard extends StatelessWidget{

  final User user;

  UserCard(this.user);

  @override
  Widget build(BuildContext context) {
    return 
    Container
    (
      margin: EdgeInsets.only(bottom: 10),
      height: 200,
      child: 
      Card
      (   
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
        child: 
        Container
        (
          padding: EdgeInsets.all(10),
          child: 
          Column
          (
            children: <Widget>
            [
              Row
              (
                children: <Widget>
                [
                  Icon(MdiIcons.account,size: 40),
                  Text(user.name, style: TextStyle(fontSize: 20),)
                ],
              ),
              Row
              (
                children: <Widget>
                [
                  Icon(MdiIcons.web, size: 40),
                  Text(user.website, style: TextStyle(fontSize: 20))
                ],
              ),
            ],
          )
        ) 
      )
    );
  } 
}