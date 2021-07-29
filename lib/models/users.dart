import 'dart:io';

import 'package:flutter/material.dart';

class User {
  final String firstName;
  final String lastName;
  final String imageUrl;
  final String email;
  final String title;
  final String jobType;
  final String mobile;

  User({
    this.firstName,
    this.lastName,
    this.imageUrl,
    this.email,
    this.title,
    this.jobType,
    this.mobile
});

  factory User.fromJson(Map<String, dynamic> jsonData){
    return User(
      firstName: jsonData['first_name'],
      lastName: jsonData['last_name'],
      imageUrl: jsonData['photo'],
      email: jsonData['email'],
      title: jsonData['title'],
      jobType: jsonData['job_type'],
      mobile: jsonData['mobile']
    );
  }
}

class Users{
  final List<dynamic> userList;

  Users({
    this.userList
});

  factory Users.fromJson(Map<String, dynamic> jsonData){
    return Users(
      userList: jsonData['users']
    );
  }
}