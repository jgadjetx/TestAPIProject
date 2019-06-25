import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:all_posts/Models/Album.dart';
import 'package:all_posts/Models/Photo.dart';
import 'package:all_posts/Models/Post.dart';
import 'package:all_posts/Models/User.dart';
import 'package:all_posts/Models/Comment.dart';
import 'package:http/http.dart' as http;

class DataProvider with ChangeNotifier {

  List<Comment> listOfPostComments = List<Comment>();
  List<User> listAllUsers = List<User>();
  List<Album> listAllAlbums = List<Album>();
  List<Photo> listAllThumbanails = List<Photo>();
  List<Post> currentPosts = List();
  List<Post> nextPosts = List();

  int page = 1;
  bool hasNextPage = true;

  void nextPage(){
    page++;
  }

  void prevPage(){
    
    if(page != 1){
      page--;
    }
  
  }

  int get getPage {
    return page;
  }


  Future<User> getUser(int userID) async {

    User user;

    String url = "https://jsonplaceholder.typicode.com/users?id=$userID";
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return user = User.fromJson(json.decode(response.body)[0]);
    } 
    else 
    {
      throw Exception("Failed To Load");
    }

  }

  

  Future<List<Post>> getPosts() async {


    String url = "https://jsonplaceholder.typicode.com/posts?_page=$page";
    final response = await http.get(url);

    if (response.statusCode == 200) {

      currentPosts = (json.decode(response.body) as List)
          .map((data) => Post.fromJson(data))
          .toList();
      
      getNextPosts();
      notifyListeners();
      return currentPosts;
    } 
    else {
      throw Exception("Failed To Load");
    } 
    
  }

  Future getNextPosts() async {
    
    String url = "https://jsonplaceholder.typicode.com/posts?_page=" + (page+1).toString();
    final response = await http.get(url);

    if (response.statusCode == 200) {

      nextPosts = (json.decode(response.body) as List)
          .map((data) => Post.fromJson(data))
          .toList();

      if(nextPosts.isEmpty){
        hasNextPage = false;
      }
      else{
        hasNextPage = true;
      }
    } 
    else {
      throw Exception("Failed To Load");
    } 
    
  }


  Future<List<Comment>> getComments(int postID) async {

    String url = "https://jsonplaceholder.typicode.com/comments?postId=$postID";

    final response = await http.get(url);

    if (response.statusCode == 200) {

      listOfPostComments = (json.decode(response.body) as List)
          .map((data) => Comment.fromJson(data))
          .toList();

      return listOfPostComments;
    }
    else{

      throw Exception("Failed To Load");
    }

  }



  Future<void> getAllAlbums() async {

    String url = "https://jsonplaceholder.typicode.com/albums";
    final response = await http.get(url);

    if (response.statusCode == 200) {
      
      listAllAlbums = (json.decode(response.body) as List)
          .map((data) => Album.fromJson(data))
          .toList();

    }
    else{

      throw Exception("Failed To Load");
    }

  }

  Future<List<Album>> getAlbums(int userID) async {

    List<Album> userAlbumList = List();

    if(listAllAlbums.isEmpty){
      await getAllAlbums();
    }

    for (int i = 0; i < listAllAlbums.length; i++) {

      if (listAllAlbums[i].userId == userID) {

        userAlbumList.add(listAllAlbums[i]);
      }

    } 
 
    return userAlbumList;
    
  }



  Future<List<Photo>> getThumbnail() async {

    if(listAllThumbanails.isEmpty){
      
      List<Photo> photoList = List();
      int tracker = 0;

      String url = "https://jsonplaceholder.typicode.com/photos";
      final response = await http.get(url);

      if (response.statusCode == 200) {

        photoList = (json.decode(response.body) as List)
            .map((data) => Photo.fromJson(data))
            .toList();

        for (int i = 0; i < photoList.length; i++) {

          if (photoList[i].albumId != tracker) {
            listAllThumbanails.add(photoList[i]);
            tracker = photoList[i].albumId;
          }

        }

        return listAllThumbanails;
      } 
      else {
        throw Exception("Failed To Load");
      }
    }
    else{
      
      return listAllThumbanails;
    }

  }

}
