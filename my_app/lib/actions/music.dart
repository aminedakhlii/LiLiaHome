import 'package:flutter/material.dart';
import 'package:my_app/utils/constants.dart';

class Music extends StatefulWidget {
  @override
  MusicState createState() => MusicState() ;

}
class MusicState extends State<Music>{
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios),
        title: Text('Music' , style: unistyle,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Container(
              height: 80,
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:
                  <Widget>[
                    Text('  Song' ,
                      style: unistyle,),
                    Icon(Icons.play_arrow,
                    color: Colors.white,
                    size: 35,),
                  ] ),
            ),
            GestureDetector(
              onTap: (){

              },
              child: Container(
                height: 80,
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:
                    <Widget>[
                      Text('  Song' ,
                        style: unistyle,),
                      Icon(Icons.play_arrow,
                        color: Colors.white,
                        size: 35,),
                    ] ),
              ),
            ),
            GestureDetector(
              onTap: (){
                setState(() {

                });
              },
              child: Container(
                height: 80,
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:
                    <Widget>[
                      Text('  Song' ,
                        style: unistyle,),
                      Icon(Icons.play_arrow,
                        color: Colors.white,
                        size: 35,),
                    ] ),
              ),
            ),
            GestureDetector(
              onTap: (){

              },
              child: Container(
                height: 80,
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:
                    <Widget>[
                      Text('  Song' ,
                        style: unistyle,),
                      Icon(Icons.play_arrow,
                        color: Colors.white,
                        size: 35,),
                    ] ),
              ),
            ),
          ],
        ),
      ),
    ) ;
  }
}