import 'package:flutter/material.dart';
import 'package:my_app/utils/constants.dart';
import 'package:my_app/utils/API.dart';

class doors extends StatefulWidget {
  String username ;
  doors(username){
    this.username = username ;
  }
  @override
  doorsState createState() => doorsState(username) ;
}
class doorsState extends State<doors> {

  String username ;
  var data ;
  doorsState(username){
    this.username = username ;
  }


  griditem(icon , text , dest) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        CircleAvatar(
          radius: 34.0,
          child: IconButton(
            icon : Icon(icon),
            iconSize: 35,
            color: Colors.white,
            onPressed: () async {
              if (dest == 'close'){
                data = await closedoor() ;
              }
              else if (dest == 'open'){
                data =  await opendoor() ;
              }
              setState(() {
                username = data ;
              });
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
              search('Doors'),
              SizedBox(height: 46.0,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.5),
                child :
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children : <Widget> [
                      Text(
                        'Old ways won''t open new doors  ' + username,
                        style: unistyle,
                      ),
                      SizedBox(height: 52.0,),
                      Text(
                        'Options ',
                        style: unistyle,
                      ),
                      SizedBox(height: 40,),
                      Container(
                          height: 150,
                          child : GridView(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount( crossAxisCount: 2 , mainAxisSpacing: 4 ),
                            children: <Widget>[
                              griditem(Icons.lock_open, 'Open', 'open'),
                              griditem(Icons.lock_outline, 'Close', 'close')
                            ],
                          )
                      ),
                      Text(
                        'Doors currently Open ',
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