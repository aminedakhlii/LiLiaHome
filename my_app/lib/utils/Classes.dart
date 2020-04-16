import 'dart:convert';
import 'package:my_app/utils/API.dart';
import 'package:flutter/material.dart';


class User {

  User(username , id , img ){
    this.username = username ;
    this.id = id ;
    this.pp = NetworkImage(gurl + 'static/' + img) ;
  }

  User.fromchat(username , id , lastmsg , img){
    this.username = username ;
    this.id = id ;
    this.lastmsg = Message.lastmsg(lastmsg) ;
    this.pp = NetworkImage(gurl + 'static/' + img) ;
  }

  factory User.chats(dynamic json) {
    return User.fromchat(json['username'] as String  , json['id'] as String , jsonDecode(json['lastmsg']) , json['image'] as String ) ;
  }

  factory User.fromJson(dynamic json){
    return User(json['username'] as String  , json['id'] as String ,  json['image'] as String ) ;
  }
  String username ;
  String id ;
  Message lastmsg ;
  NetworkImage pp  ;
}








class Message {

  Message(message , sender_id , reciever_id ,  day , time){
    this.time = time ;
    this.day = day ;
    this.message = message ;
    this.sender_id = sender_id ;
    this.reciever_id = reciever_id ;
  }

  Message.last(message , time , datetime) {
    this.dateTime = DateTime.parse(datetime) ;
    this.time = time ;
    this.message = message ;
  }

  factory Message.fromJson(dynamic json){
    return Message(json['message'] as String , json['sender'] as int ,
        json['reciever'] as int , json['day'] as String
    , json['time'] as String);
  }

  factory Message.lastmsg(dynamic json){
    return Message.last(json['message'] as String , json['time'] as String , json['datetime'] as String);
  }

  String message ;

  bool likedby(User) {
    return false ;
  }

  int sender_id ;
  int reciever_id ;
  String time ;
  String day ;
  DateTime dateTime ;
}

class Event {

}

class Option {
  Option(name , dest){
    optionName = name ;
    destination = dest ;
  }
  String optionName ;
  String destination ;
}


