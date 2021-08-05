import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserScreen extends StatefulWidget {
  static const String id = "USERSCREEN";

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {


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
                return ListView.builder(itemBuilder: (_, index) {
                  var data = (snapShot.data as dynamic)['users'][index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    padding: EdgeInsets.only(bottom: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  width: 60,
                                ),
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage("https://ribsandburgers.com"
                                          "/au/wp-content/uploads/2019/03/"
                                          "2-angus-bacon-and-cheese.jpg"),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name: ${data['first_name']} "
                                  "${data['last_name']}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text('email: ${data["email"]}',
                                    style: textStyle),
                                Text("title: ${data['title']}",
                                    style: textStyle),
                                Text("Job Type: ${data['job_type']}",
                                    style: textStyle),
                                Text("mobile: ${data['mobile']}",
                                    style: textStyle),
                              ],
                            ),
                          ],
                        ),
                      ],
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

  TextStyle textStyle = TextStyle(
    fontSize: 16,
    height: 1.8,
  );
}
