import 'package:flutter/material.dart';
import 'package:my_app/admin/memberslist.dart';
import 'package:my_app/utils/API.dart';
import 'dart:convert';
import 'package:my_app/utils/constants.dart';
//import 'package:speech_to_text/speech_to_text.dart' as stt;



class Adminroute extends StatefulWidget {
  @override
  _AdminRouteState createState() => _AdminRouteState() ;
}
class _AdminRouteState extends State<Adminroute> {

  String url = 'http://192.168.1.11:9877/getnum' ;

  List<String> member_names = [] ;


  search(){
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          )
      ),
      child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: AssetImage("/assets/ssss.png"),

                    ),
                    SizedBox(width: 10.0),
                    Text(
                    'Admin Panel',
                    style: TextStyle(fontSize: 20.0 , fontWeight: FontWeight.bold, color: Colors.white)
                    ),

                  ],
                ),

              ],
            ),

          ]
      ),
    );
  }






  gridItem(icon,text, dest) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          CircleAvatar(
            child: IconButton(
              icon : Icon(icon),
              color: Colors.white,
              onPressed: () async {
                if (dest == 'members'){
                  var members_ = await get_all_members() ;
                  List<String> temp = [] ;

                  for(int i = 0 ; i < json.decode(members_).length ; i++){
                    temp.add(json.decode(members_)[i]['username']) ;
                  }

                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Members(temp))
                  );
                }
                else if(dest =='add'){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddMember())
                  );
                }
                else {
                  /*print('listen dest');
                  stt.SpeechToText speech = stt.SpeechToText();
                  print('here1');
                  bool available = await speech.initialize(onStatus: (l) {print('status ' +l) ; } , onError: (e) {print('error'+e.toString()) ; });
                  if ( available ) {
                    speech.listen( onResult: (r) {print(r.toString()) ;} , listenFor: Duration(seconds: 10));
                  }
                  else {
                    print("The user has denied the use of speech recognition.");
                  }
                  //speech.stop();*/
                }
              },
            ),
            maxRadius: 25.0,
            backgroundColor: Theme.of(context).primaryColor,
          ),
          SizedBox(width: 10.0,),
          Text(
            text,
            style: unistyle,
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: ListView(
        children : <Widget>[
          search() ,
          SizedBox(height: 15.0,),
          Padding(
            padding: EdgeInsets.only(left: 12.0),

          ),
          SizedBox(height : 20.0),
          Container(
            height: 400.0,
            child : ListView(

                children: <Widget>[
            gridItem(Icons.person_add , 'add member' , 'add'),
            gridItem(Icons.remove , 'remove member' , 'remove'),
            gridItem(Icons.people , 'family members' , 'members'),
            gridItem(Icons.room , 'listen' , 'listen'),

              ]
    ),
          ),
          GestureDetector(
            onHorizontalDragEnd: (DragEndDetails) => Navigator.pop(context),
          ),]
      ),
    );
  }
}
