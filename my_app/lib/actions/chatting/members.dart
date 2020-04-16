import 'package:flutter/material.dart';
import 'package:my_app/utils/API.dart';
import 'dart:convert';
import 'package:my_app/utils/constants.dart';
import 'package:my_app/actions/chatting/chatscreen.dart';
import 'package:my_app/utils/internalApis.dart';
import 'package:my_app/utils/Classes.dart';


String me ;

void get_me() async {
  var objid = await my_id() ;
  me = objid ;
}

class FamMembers extends StatefulWidget{

  FamMembers();
  @override
  FamMembersState  createState() => FamMembersState();
}

class FamMembersState extends State<FamMembers>{
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.0),
      child: Column(
       children : <Widget>[
       Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child : Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
              'Family members',
              style : TextStyle( color: Colors.white , fontSize: 18.0 , fontWeight: FontWeight.bold , letterSpacing: 0.8)
          ),
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.more_horiz),
            iconSize: 20.0,
            onPressed: () {} ,
          )
        ],
      ),
      ),
       Container(
         height: 120.0,
         //color: Colors.blue,
         child: FutureBuilder(
           future: fillmembers(),
           builder: (BuildContext context , AsyncSnapshot snap){
           return ListView.builder(
               padding: EdgeInsets.only(left: 10.0),
               scrollDirection: Axis.horizontal,
               itemCount: members.length,
               itemBuilder: (BuildContext context , int index){
                 get_me() ;
                 return
                   GestureDetector(
                     onTap: () async {
                       Navigator.push(context,
                           MaterialPageRoute(
                               builder: (_) => ChatScreen(me: me , friend: members[index].id, name: members[index].username,))
                       );

                     },
                     child: Padding(
                       padding: EdgeInsets.all(8.0),
                       child: Column(
                       children : <Widget> [
                         CircleAvatar(
                           backgroundImage: members[index].pp,
                           radius: 30.0,
                         ),
                         SizedBox(height: 6.0,),
                         Text(members[index].username,
                           style:
                           TextStyle(
                               color: Colors.white ,
                               fontSize: 19.0,
                               fontWeight: FontWeight.bold
                           ),
                         ),
                 ]
                       ),
                     ),
                   );
               },
           );
  }
         ),
       )
      ],
      ),
    );
  }
}

// ----------------------------------------------------------------------------

List<User> members = [];
List<User> chats = [] ;

Future fillmembers() async {
  members = [] ;
  var members_ = await get_all_members() ;
  for(int i = 0 ; i < json.decode(members_).length ; i++){
    User temp = User.fromJson(json.decode(members_)[i]) ;
    members.add(temp) ;
  }
}

Future fill_chats() async {
  get_me();
  chats = [] ;
  var chatsheads = await get_chats_list(me);
  int length = json.decode(chatsheads).length ;
  for (int i=0 ; i< length ; i++){
    User temp = User.chats(json.decode(chatsheads)[i]) ;
    chats.add(temp);
  }
  bubble_sort(chats) ;
}

void bubble_sort(array){
  for(int i = 0 ; i < array.length - 1 ; i++) {
    for (int j = 0 ; j < array.length - i - 1 ; j++ ){
      if (array[j].lastmsg.dateTime.isBefore(array[j+1].lastmsg.dateTime)) {
        User temp = array[j] ;
        array[j] = array[j+1];
        array[j+1] = temp ;

      }
    }
  }
}





class RecentChats extends StatefulWidget {




  List<String> lastmsg ;

  RecentChats();
  @override
  RecentState createState() => RecentState();
}

class RecentState extends State<RecentChats> {


  Widget build(BuildContext context){
    return Expanded(
      child: Container(
        height: 300.0,
        decoration: BoxDecoration(color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
                topLeft:  Radius.circular(30.0) , topRight: Radius.circular(30.0))
        ),
        child: ClipRRect(
          borderRadius : BorderRadius.only(
              topLeft:  Radius.circular(30.0) ,
              topRight: Radius.circular(30.0)
          ),
          child: FutureBuilder(
            future: fill_chats(),
            builder: (BuildContext context , AsyncSnapshot snap) {
              return ListView.builder(
                itemCount: chats.length,
                itemBuilder: (BuildContext context, int index) {
                  get_me();

                  return GestureDetector(
                    onTap: () async {
                      String me = await my_id();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) =>
                              ChatScreen(me: me, friend: chats[index].id, name : chats[index].username))
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      margin: EdgeInsets.only(
                          top: 5.0, bottom: 5.0, right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage: chats[index].pp,
                                  radius: 28.0,
                                ),
                                SizedBox(width: 10.0,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      chats[index].username,
                                      style: unistyle,
                                    ),
                                    SizedBox(height: 5.0,),
                                    Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 0.45,
                                      child: Text(
                                        chats[index].lastmsg.message,
                                        style: TextStyle(color: Colors.white),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                              ]
                          ),

                          Row(
                            children: <Widget>[
                              Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      chats[index].lastmsg.time.toString(),
                                      style: TextStyle(color: Colors.white70,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 3.0,),
                                    Container(
                                      width: 30.0,
                                      height: 20.0,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              20.0),
                                          color: Theme
                                              .of(context)
                                              .primaryColor),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'New',
                                        style: TextStyle(color: Colors.white70,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11.0),
                                      ),
                                    ),
                                  ]
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          ),
        ),
      ),
    );
  }
}





