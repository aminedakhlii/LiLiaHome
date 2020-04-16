import 'package:flutter/material.dart';

final primarycolor = Colors.teal[600] ;


  final unistyle = TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 20);
  final smallText = TextStyle(color: Colors.white , fontWeight: FontWeight.w800 , fontSize: 15);
  search(name) {
   return Container(
padding: EdgeInsets.all(16.0),
decoration: BoxDecoration(
color: primarycolor,
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
Row(
mainAxisAlignment: MainAxisAlignment.spaceAround,
children : <Widget> [
Text(
name,
style: TextStyle(fontSize: 20.0 , fontWeight: FontWeight.bold, color: Colors.white)
),
Icon(
Icons.lightbulb_outline,
color: Colors.white,
)
]
)
],
),

],
),

]
),
);
}

class Theme_ {
    Color Primary ;
    Color Secondairy ;
    Theme(c1,c2){
      this.Primary = c1 ;
      this.Secondairy = c2 ;
    }
  }
/*
  Theme_ Dark = new Theme_(Colors.teal[500] , Colors.blueGrey[800]) ;
  Theme_ DarkGirly(Color(Colors.pink[500]) , Color(Colors.blueGrey[800])) ;
  Theme_ Light(Color(Colors.blue[100]) , Color(Colors.white)) ;
*/

