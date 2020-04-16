import 'package:flutter/material.dart';
import 'package:my_app/utils/API.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/utils/internalApis.dart';

class SecondRoute extends StatefulWidget {
  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  String url = 'http://192.168.1.13:9877/lilia' ;
  String loginurl ;
  var Data , loginData , test  , resp;
  String val ;
  String QueryText ;
  String username , password , loginresponse;
  bool txt = false , txt2 = false;




  void loggedornot() async {
    final prefs = await SharedPreferences.getInstance();
    bool ret = prefs.getBool('islogged') ?? false ;
    bool admin = prefs.getBool('isadmin') ?? false ;
    print(ret) ;
    setState(() {
      if(ret == true) {
        if (admin == true)
        QueryText = 'logged as admin';
        else QueryText = 'logged as member' ;
      }
      else
        QueryText = 'notlogged';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: ListView(
        children: <Widget> [

          TextField(
            onChanged: (value) {
            //  url = 'http://192.168.15.61:9877/lilia' + value.toString();
            username = value ;
            val = value ;

              print(value.toString()) ;
            },
            decoration: InputDecoration(
                hintText: 'type command',
                suffixIcon: GestureDetector(
                    onTap: () async {
                      Data = await api(val);

                      setState(() {
                        QueryText = Data ;
                        //txt = true ;
                      });
                    },

                    child: Icon(Icons.send))),
          ),
    TextField(
    onChanged: (value) {
    //url = 'http://192.168.1.19:9877/lilia?q=' + value.toString();
    password = value ;
    print(value.toString()) ;
    },
    decoration: InputDecoration(
    hintText: 'type command',
    suffixIcon: GestureDetector(
    onTap: () async {
    Data = await api(val);

    setState(() {
    QueryText = Data ;
    txt = true ;
    });
    },

    child: Icon(Icons.send))),
    ),


     RaisedButton(
    onPressed: () async {
      login(username,password) ;
      setState(() async {


        txt = true ;
      });
    },
    child: Text('login'),
    ),
    if (txt) Text(
          'response : ' +  loginresponse , style: TextStyle( fontSize : 18 , fontWeight: FontWeight.bold ,
          color: Colors.pink ,
    ) ),



    RaisedButton(
    onPressed: () async {
    await loggedornot() ;
    setState(() {
    txt2 = true ;
    });
    },
    child: Text('test login'),
    ),
    if (txt2) Text(
    'response : ' +  QueryText , style: TextStyle( fontSize : 18 , fontWeight: FontWeight.bold ,
    color: Colors.pink ,
    ) ),
    RaisedButton(
    onPressed: () async {
    logout() ;
    },
    child: Text('logout'),
    ),
      ]),
    );
  }
}