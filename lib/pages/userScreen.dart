import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserScreen extends StatefulWidget {
  static const String id = "USERSCREEN";

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
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
                return ListView.builder(
                    itemBuilder: (_, index) {
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
                      title: Text(
                        snapShot.data['users'][index]['first_name'] + " " +
                            snapShot.data['users'][index]['last_name'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                        ),
                      ),

                      subtitle: Text(
                        "email: " +
                            snapShot.data['users'][index]['email'] +
                        " \ntitle: " +
                            snapShot.data['users'][index]['title'] +
                        "\nJob Type: " +
                            snapShot.data['users'][index]['job_type'] +
                        "\nMobile: " +
                            snapShot.data['users'][index]['mobile'],
                        style: TextStyle(
                            height: 1.4,
                            fontSize: 15
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
}

class CustomListView extends StatelessWidget {
  final NetworkImage image;
  final String name;
  final String email;
  final String title;
  final String jobType;
  final String mobile;

  const CustomListView(
      {Key key,
      this.image,
      this.name,
      this.email,
      this.title,
      this.jobType,
      this.mobile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        child: CircleAvatar(
          backgroundImage: image,
        ),
      ),
    );
  }
}
