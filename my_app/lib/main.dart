import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:my_app/testing/commands.dart';
import 'package:my_app/actions/login.dart';
import 'package:my_app/utils/internalApis.dart';
import 'package:my_app/actions/home.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final title = 'WebSocket Demo';
    return MaterialApp(
      home: MyHomePage(
    title: title,
      ),
      theme: ThemeData(
        primaryColor:Colors.teal[600] ,
        accentColor: Colors.blueGrey[800] ,


      ),

    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title }) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if(index == 1){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SecondRoute()),
        );
      }
    });
  }



  @override
  Widget build(BuildContext context) {

    return

      Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: FutureBuilder(
        future: loggedornot(),
         builder : (BuildContext context , snap) {
          if(snap.data == 0){
          return  Column(
             crossAxisAlignment: CrossAxisAlignment.end,
             children: <Widget>[
               Expanded(
                   child: Container(
                       child: Login()
                   )
               ),
             ],
           ); }
           else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Expanded(
                    child: Container(
                        child: Home()
                    )
                ),
              ],
            );
          }
         }
      )
       // This trailing comma makes auto-formatting nicer for build methods.
    );

  }
}

