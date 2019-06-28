import 'dart:core';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:all_posts/Models/Album.dart';
import 'package:all_posts/Models/Photo.dart';
import 'package:all_posts/Models/Post.dart';
import 'package:all_posts/Models/User.dart';
import 'package:all_posts/Models/Comment.dart';
import 'package:all_posts/Models/ThumbnailAndTitle.dart';
import 'package:http/http.dart' as http;


class DataProvider with ChangeNotifier {

  List<Comment> listOfPostComments = List<Comment>();
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

  Future<http.Response> makeAPICall(String url) async{

    final response = await http.get(url);
    
    return response;
  }

  Future<User> getUser(int userID) async {
    User user;

    var response = await makeAPICall("https://jsonplaceholder.typicode.com/users?id=$userID");

    if (response.statusCode == 200) {
      return user = User.fromJson(json.decode(response.body)[0]);
    } 
    else 
    {
      throw Exception("Failed To Load");
    }

  }

  Future<List<Post>> getPosts() async {

    var response = await makeAPICall("https://jsonplaceholder.typicode.com/posts?_page=$page");

    Map<String, String> headers = response.headers;
    String linkHeader= headers['link'];

    if (response.statusCode == 200) {

      currentPosts = (json.decode(response.body) as List)
          .map((data) => Post.fromJson(data))
          .toList();
      
      if(linkHeader.contains('rel="next"')){
        hasNextPage = true;
      }
      else{
        hasNextPage = false;
      }

      notifyListeners();
      return currentPosts;
    } 
    else {
      throw Exception("Failed To Load");
    } 
    
  }

  //Random commnet for testing CI/CD
  Future<List<Comment>> getComments(int postID) async {


    var response = await makeAPICall("https://jsonplaceholder.typicode.com/comments?postId=$postID");

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


  Future<List<Album>> getUserAlbums(int userID) async {

    List<Album> listOfUserAlbums;
    var response = await makeAPICall("https://jsonplaceholder.typicode.com/albums?userId=$userID");
  
    if (response.statusCode == 200) {

      listOfUserAlbums = (json.decode(response.body) as List)
          .map((data) => Album.fromJson(data))
          .toList();

      return listOfUserAlbums;
    }
    else{

      throw Exception("Failed To Load");
    }
    
  }

  Future<List<ThumbnailAndTitle>> getUserThumbnail(int userID) async{

    List<Album> listOfUserAlbums = await getUserAlbums(userID);

    Album album;
    Photo photo;

    ThumbnailAndTitle thumbnailAndTitle;
    List<ThumbnailAndTitle> thumbnailAndTitleList = List<ThumbnailAndTitle>();
    

    for(int i = 0; i < listOfUserAlbums.length; i++){

      int albumID = listOfUserAlbums[i].id;
      var response = await makeAPICall("https://jsonplaceholder.typicode.com/photos?albumId=$albumID&_limit=1");

      if (response.statusCode == 200) {

        photo = Photo.fromJson(json.decode(response.body)[0]);
        album = listOfUserAlbums[i];
        thumbnailAndTitle = ThumbnailAndTitle(photo.thumbnailUrl, album.title);

        thumbnailAndTitleList.add(thumbnailAndTitle);
        
      } 
      else 
      {
        throw Exception("Failed To Load");
      }

    }

    return thumbnailAndTitleList;

  }


}
