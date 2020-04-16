import 'package:flutter/material.dart';
import 'package:my_app/actions/chatting/categories.dart';
import 'package:my_app/actions/chatting/members.dart';


class chatroute extends StatefulWidget {


  @override
  _chatRouteState createState() => _chatRouteState();
}

class _chatRouteState extends State<chatroute> {


  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
       appBar: AppBar(
         leading: IconButton(
             icon: Icon(Icons.menu) ,
             iconSize : 30.0,
             color: Colors.white ,
             onPressed: () {}
         ),
         title: Text(
           'Chats',
           style: TextStyle(
             fontSize: 28.0,
             fontWeight: FontWeight.bold ,
             color: Colors.white
           ),
         ),
         elevation: 0.0,
         actions: <Widget>[
           IconButton(
               icon: Icon(Icons.search) ,
               iconSize : 30.0,
               color: Colors.white ,
               onPressed: () {}
           ),
         ],
       ),
      body: Column(
        children: <Widget>[
              CategorySelector(),
              Expanded(
                child :Container(
                  decoration: BoxDecoration(color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only( topLeft:  Radius.circular(30.0) , topRight: Radius.circular(30.0))
                  ),
                child: Column(
                  children: <Widget>[
                    FamMembers(),
                    RecentChats(),
                  ],
                ),
              ),
              ),
        ],
      ),
    );
  }

}