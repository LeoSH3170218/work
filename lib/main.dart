import 'package:flutter/material.dart';
import 'package:task1_kamlesh/pages/user_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      routes: {
        MyHomePage.id : (context) => MyHomePage(title: 'Home',),
        UserScreen.id: (context) => UserScreen(),
      },
      home: MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const String id = "HOME_SCREEN";
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child:
            CustomButton(
              text: "Get User",
              callback: () {
                Navigator.of(context).pushNamed(UserScreen.id);
              },
              color: Colors.cyan,
            ),
        ),
    );
  }
}

class CustomButton extends StatelessWidget{
  final VoidCallback callback;
  final String text;
  final Color color;

  const CustomButton({Key? key, required this.callback, required this.text, required this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Material(
        color: color,
        elevation: 6.0,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: callback,
          minWidth: 200.0,
          height: 45,
          child: Text(
            text,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18
            ),
          ),
        ),
      ),
    );
  }
}
