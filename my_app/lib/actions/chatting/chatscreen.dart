import 'package:flutter/material.dart';
import 'package:my_app/utils/constants.dart';
import 'package:my_app/utils/API.dart';
import 'package:my_app/utils/internalApis.dart';
import 'package:my_app/utils/Classes.dart';
import 'dart:convert';
import 'dart:async';



class ChatScreen extends StatefulWidget {

  String me , friend , name ;
  ChatScreen({this.me , this.friend , this.name}) ;

  @override
  ChatState createState()  =>  ChatState() ;

}

class ChatState extends State<ChatScreen> {

  String new_message ;

  @override
  void initState() {

    super.initState();
  }


  Stream<Future<List<Message>>>  finalconv () async* {
    yield* Stream.periodic(Duration(seconds: 1), (int a) async {
       var future_ =  await get_messages_() ;
       return future_ ;
  });
  }

  Future<List<Message>> get_messages_ () async {
    List<Message> messages = [];
      var messages_ = await get_messages(widget.me, widget.friend);
      for (int i = 0; i < json
          .decode(messages_)
          .length; i++) {
        Message temp = Message.fromJson(json.decode(messages_)[i]);
        messages.add(temp);
      }
      return messages;

  }

  _build_message(String msg , bool mine , time ){
    final message = Container(
      width: MediaQuery.of(context).size.width * 0.75 ,
      margin: mine ? EdgeInsets.only(
          top : 8.0 ,
          bottom: 8.0 ,
          left: 80.0)
          : EdgeInsets.only(
        top : 8.0 ,
        bottom: 8.0 ,
      ),
      padding: EdgeInsets.symmetric(horizontal: 25.0 , vertical: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(time , style: TextStyle(color: Colors.white70 , fontWeight: FontWeight.w600 , fontSize: 15),),
          Text(msg , style: TextStyle(color: Colors.white , fontWeight: FontWeight.w600 ,fontSize: 17),),
        ],
      ),
      decoration:
      BoxDecoration(
          color: mine ? Theme.of(context).primaryColor : Colors.grey[600] ,
          borderRadius:
          mine ?
          BorderRadius.only(topLeft : Radius.circular(15.0) ,
              bottomLeft: Radius.circular(15.0)) :
          BorderRadius.only(topRight : Radius.circular(15.0) ,
              bottomRight: Radius.circular(15.0))
      ),
    );

    if(mine) return message ;
    else return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        message ,
        !mine ? IconButton(
          icon: Icon(Icons.favorite_border),
          iconSize: 35.0,
          color: Colors.blueGrey,
          onPressed: () {

          },
        ) : SizedBox.shrink()
      ],
    );
  }


  buildcomposer(){
    return Container(
      height: 70.0,
      color: Theme.of(context).accentColor,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25.0,
            color: Colors.white70,
            onPressed: () {
            },
          ),
          Expanded(
            child: TextField(
              style: TextStyle(color: Colors.white70 , fontWeight: FontWeight.w600),
              decoration: InputDecoration.collapsed(hintText: 'Type a message ...' ,
                hintStyle: TextStyle(color: Colors.white30 , fontWeight: FontWeight.w500),
                  ),
              onChanged: (value){
                  new_message = value ;
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Colors.white70,
            onPressed: () async {
              var obj_id =  await my_id() ;
              String me = obj_id ;
              await send_message(new_message, widget.me , widget.friend) ;
              FocusScope.of(context).unfocus();
            }
          ),

        ],
      ),

    );
  }



  Widget build(BuildContext context)  {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading:  Padding(
          padding: EdgeInsets.only(top : 8.0 , left: 5.0),
          child: CircleAvatar(
            radius: 30.0,
          ),
        ),
        title: Text( widget.name , style: unistyle,),
          elevation: 0.0 ,
      actions: <Widget>[
        IconButton(icon: Icon(Icons.more_horiz), onPressed: () {}),
      ],),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: EdgeInsets.only(top: 11.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.only(
                          topLeft:  Radius.circular(30.0) ,
                          topRight: Radius.circular(30.0))
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft:  Radius.circular(30.0) ,
                        topRight: Radius.circular(30.0)),
                    child: StreamBuilder(
                      stream: finalconv(),
                      builder: (BuildContext context , AsyncSnapshot snap1) {
                        if(snap1.data == null) { return Row(
                          mainAxisAlignment : MainAxisAlignment.center,
                          children: <Widget>[
                            CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                          ],
                        ) ;  }
                        else{
                        return FutureBuilder(
                          future: get_messages_() ,
                          builder: (BuildContext context , AsyncSnapshot snap) {
                            if(snap.data == null) { return Row(
                              mainAxisAlignment : MainAxisAlignment.center,
                              children: <Widget>[
                                CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),),
                              ],
                            ) ;  }
                            else {
                              return
                                ListView.builder(
                                    reverse: true,
                                    padding: EdgeInsets.only(top: 35.0),
                                    itemCount: snap.data.length,
                                    itemBuilder: (BuildContext context,
                                        int index) {
                                      bool alternate = (snap.data[index].sender_id == int.parse(widget.me)) ;
                                      return _build_message(
                                          snap.data[index].message, alternate , snap.data[index].time);
                                    }
                                );
                            }
                          }
                        ) ;
                        }
                      },
                    ),
                  ),
                ),
              ),
              buildcomposer(),
            ],
          ),
        ),
      ),
    );
  }
}

