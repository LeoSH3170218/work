import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserScreen extends StatefulWidget {
  static const String id = "USERSCREEN";

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  String stringConcatenation(String firstString, String secondString) {
    return firstString + ": " + secondString;
  }
  TextStyle textStyle = TextStyle(
    fontSize: 16,
    height: 1.8
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //displayUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body: Center(
        child: FutureBuilder(
          future: displayUser(),
          builder: (ctx, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              if (snapShot.data != null) {
                AsyncSnapshot<Object?> x = snapShot;
                return ListView.builder(itemBuilder: (_, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    padding: EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage("https://ribsandburgers.com"
                                "/au/wp-content/uploads/2019/03/"
                                "2-angus-bacon-and-cheese.jpg"),
                      ),
                      title: Container(
                        child: Row(
                          children: [
                            Text(
                              ((snapShot.data as dynamic)['users'][index]
                                      ['first_name']) +
                                  " " +
                                  (snapShot.data as dynamic)['users'][index]
                                      ['last_name'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      subtitle: Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(stringConcatenation(
                                    "email",
                                    (snapShot.data as dynamic)['users'][index]
                                        ['email']),
                                  style: textStyle
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(stringConcatenation(
                                    "title",
                                    (snapShot.data as dynamic)['users'][index]
                                        ['title']),
                                  style: textStyle
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(stringConcatenation(
                                    "Job Type",
                                    (snapShot.data as dynamic)['users'][index]
                                        ['job_type']),
                                  style: textStyle
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(stringConcatenation(
                                    "mobile",
                                    (snapShot.data as dynamic)['users'][index]
                                        ['mobile']),
                                  style: textStyle
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
              } else {
                return Text("something went wrong");
              }
            }
          },
        ),
      ),
    );
  }

  Future displayUser() async {
    //var userApi = UserApi();
    //var data = await userApi.getUsers();
    final String url =
        "https://fakemyapi.com/api/fake?id=3757e010-c20c-4820-b006-ddf44da88a77";
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var users = json.decode(response.body);

      return users;
    }
  }
}
