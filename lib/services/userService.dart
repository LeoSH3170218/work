import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/users.dart';

class UserApi{
  final String url =
      "https://fakemyapi.com/api/fake?id=3757e010-c20c-4820-b006-ddf44da88a77";

  Future<List<User>> getUsers() async{
    http.Response response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      String dataBody = response.body;
      var jsonData = jsonDecode(dataBody);
      Users users = Users.fromJson(jsonData);
      List<User> userList = users.userList.map((e) => User.fromJson(e)).toList();
      return userList;
    }else{
      print("something went wrong");
      return null;
    }
  }
}