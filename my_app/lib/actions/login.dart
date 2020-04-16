import 'package:flutter/material.dart';
import 'package:my_app/utils/internalApis.dart';
import 'package:my_app/actions/home.dart';
import 'package:my_app/utils/constants.dart';


class Login extends StatefulWidget {
  @override
  _addState createState() => _addState() ;
}

class _addState extends State<Login> {

  String username , password ;
  var res ;
  String response ;
  bool responseav = false  ;

  search(){
    return Container(
      height: 65,
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
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                         Icons.home,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    SizedBox(width: 25,),
                    Text(
                        'Welcome Home',
                        style: TextStyle(fontSize: 25.0 , fontWeight: FontWeight.bold, color: Colors.white)
                    ),
                  ],
                ),

              ],
            ),

          ]
      ),
    );
  }

  int LoginRes ;

  Widget build(BuildContext context) {
    return  ListView(
            children : <Widget> [
            search(),
        SizedBox(height: 50.0,),
        Container(
            height: 500.0,
            child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, childAspectRatio: 3.6),
                children: <Widget>[
                  Padding(
                  padding:EdgeInsets.only(left: 25.0 , right: 25.0  ),
                  child: Text('Login' , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold
    ,fontSize: 33.0 ,  letterSpacing: 1.5
    ),),
              ),
            Padding(
            padding : EdgeInsets.only(left: 25.0 , right: 25.0),
            child :
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children : <Widget> [
                  Text('Username' , style: TextStyle( color : Colors.white , fontWeight: FontWeight.bold),),
                  SizedBox(height: 10.0,),
                  TextFormField(
                    style: TextStyle(
                      color: Colors.white,

                    ),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13.0)
                      ),
                      hoverColor: Colors.white,
                      hintText: 'username' ,
                      hintStyle: TextStyle(
                        color: Colors.white54,
                        fontFamily: 'OpenSans',
                      ),

                    ),
                    onChanged: (value) {
                      username = value ;
                    },

                  ),
                  SizedBox(height: 10.0,)
                ]
            )
        ),
        Padding(
            padding : EdgeInsets.only(left: 25.0 , right: 25.0),
            child : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children : <Widget>
                [
                  Text('Password' , style: TextStyle( color : Colors.white , fontWeight: FontWeight.bold),),
                  SizedBox(height: 10.0,),
                  TextFormField(
                    obscureText: true,
                    style: TextStyle(
                      color: Colors.white,

                    ),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(

                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13.0)
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      hoverColor: Colors.white,
                      hintText: 'password' ,
                      hintStyle: TextStyle(
                        color: Colors.white54,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                    onChanged: (value) {
                      password = value ;
                    },
                  ),
                  SizedBox(height: 10.0,)

                ]
            )
        ),

        Container(
            padding: EdgeInsets.symmetric(vertical: 20.0 , horizontal: 50.0),
            child : FloatingActionButton(
                onPressed: () async {
                  await login(username , password) ;
                  if(await loggedornot() !=  0 )
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Home()));
                  else errorLogin = true ;
                },
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(Icons.lock_open),
    )
        ),
                  if(errorLogin)
                    Text('Error while logging try again ', style : unistyle),
                 

    ],
    ),
    ),
    ]
    );
  }
  bool errorLogin = false ;
}