import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:all_posts/Models/Album.dart';
import 'package:all_posts/Models/Photo.dart';
import 'package:all_posts/Models/Post.dart';
import 'package:all_posts/Models/User.dart';
import 'package:all_posts/Models/Comment.dart';
import 'package:http/http.dart' as http;

class DataProvider with ChangeNotifier{
  
  Future<List<User>> getUsers() async{
    
    List<User> list = List();
   
    String url = "https://jsonplaceholder.typicode.com/users";
    final response = await http.get(url);

    if(response.statusCode == 200){
      
      list = (json.decode(response.body) as List).map((data)=> User.fromJson(data)).toList();
      return list;
    }
    else{
      throw Exception("Failed To Load");
    }

  }

  Future<User> getUser(int userID) async{

    List<User> allUsers = await getUsers();
    User user;

    for(int i = 0; i <= allUsers.length; i++){

      if(allUsers[i].id == userID){
        user = allUsers[i];
        break;
      }
    }

    return user;

  }


  Future<List<Post>> getPosts() async{
    
    List<Post> list = List();
   
    String url = "https://jsonplaceholder.typicode.com/posts";
    final response = await http.get(url);

    if(response.statusCode == 200){
      
      list = (json.decode(response.body) as List).map((data)=> Post.fromJson(data)).toList();
      return list;
    }
    else{
      throw Exception("Failed To Load");
    }

  }


Future<List<Comment>> getComments(int postID) async {
    
    List<Comment> allComments = List();
    List<Comment> postComments = List();
   
    String url = "https://jsonplaceholder.typicode.com/comments";
    final response = await http.get(url);

    if(response.statusCode == 200){
      
      allComments = (json.decode(response.body) as List).map((data)=> Comment.fromJson(data)).toList();

      for(int i = 0; i <= allComments.length; i++){
        
        if(allComments[i].postId == postID){
          postComments.add(allComments[i]);
        }

      }

      return postComments;
    }
    else
    {
      throw Exception("Failed To Load");
    }

}


  Future<List<Album>> getAlbums(int userID) async{
    
    List<Album> allAlbums = List();
    List<Album> userAlbumList = List();
   
    String url = "https://jsonplaceholder.typicode.com/albums";
    final response = await http.get(url);

    if(response.statusCode == 200){
      
      allAlbums = (json.decode(response.body) as List).map((data)=> Album.fromJson(data)).toList();

      for(int i = 0; i <= allAlbums.length; i++){

        if(allAlbums[i].userId == userID){
          userAlbumList.add(allAlbums[i]);
        }
      }

      return userAlbumList;
    }
    else
    {
      throw Exception("Failed To Load");
    }

  }

  Future<List<Photo>> getThumbnail() async{

    List<Photo> photoList = List();
    List<Photo> thumbnailList  = List();
    int tracker = 0;
   
    String url = "https://jsonplaceholder.typicode.com/photos";
    final response = await http.get(url);

    if(response.statusCode == 200){
      
      photoList = (json.decode(response.body) as List).map((data)=> Photo.fromJson(data)).toList();

      for(int i = 0; i <= photoList.length ; i++){

        if(photoList[i].albumId != tracker){
          thumbnailList.add(photoList[i]);
          tracker = photoList[i].albumId;
        }
      }
      return thumbnailList;
      
    }
    else{

      throw Exception("Failed To Load");
    }

  }


  
}

