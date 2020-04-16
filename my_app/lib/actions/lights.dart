import 'package:flutter/material.dart';
import 'package:my_app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Lights extends StatefulWidget {
  String username ;
  Lights(username){
    this.username = username ;
  }
  @override
  lightsState createState() => lightsState(username) ;
}
class lightsState extends State<Lights> {

  String username ;
  lightsState(username){
    this.username = username ;
  }


  griditem(icon , text , dest) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        CircleAvatar(
          radius: 30.0,
          child: IconButton(
            icon : Icon(icon),
            iconSize: 35,
            color: Colors.white,
            onPressed: () async {

            },
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        SizedBox(height: 10.0,),
        Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }



  Widget build(BuildContext context) {
          return Scaffold(
            backgroundColor: Theme.of(context).accentColor,
           body : ListView(

             children : <Widget> [
                  search('Lights') ,
               SizedBox(height: 46.0,),
               Padding(
               padding: EdgeInsets.symmetric(horizontal: 12.5),
                child :
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children : <Widget> [
                    Text(
                      'Be the light that helps others see ' + username,
                      style: unistyle,
                    ),
                SizedBox(height: 52.0,),
                Text(
                 'Options ',
                 style: unistyle,
               ),
               SizedBox(height: 30,),
               Container(
                height: 150,
                   child : GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount( crossAxisCount: 2 , mainAxisSpacing: 4 ),
                        children: <Widget>[
                              griditem(Icons.lightbulb_outline, 'Turn On', ''),
                              griditem(Icons.format_list_bulleted, 'Turn Off', '')
                 ],
               )
               ),
                  Text(
                    'Lights currently On ',
                    style: unistyle,
                  ),
               ]
                ),

               ),
                  GestureDetector(
                    onHorizontalDragEnd: (DragEndDetails) => Navigator.pop(context),
                  ),
             ]
           )
    );
  }
}