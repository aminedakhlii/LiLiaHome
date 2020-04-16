import 'package:flutter/material.dart';
import 'package:my_app/utils/API.dart';

class Members extends StatefulWidget {
  List<String> names = [] ;
  Members(names) {
    this.names = names ;
  }
  @override
  membersstate createState () => membersstate() ;
}
class membersstate extends State<Members> {


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
                        'Family Members',
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
  printname(name){
    return Text(
        name,
        style: TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white)

    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Theme.of(context).accentColor ,
      body: ListView(
        children: <Widget>[
          search(),
        for (var x in widget.names)
        ListTile(
        leading: Icon(Icons.person_outline , color: Colors.white,),
            title: printname(x),
        ),
        GestureDetector(
        onHorizontalDragEnd: (DragEndDetails) => Navigator.pop(context),
         ),
        ],
      ),
    );

  }
}



// ---------------------------------------------------------




class AddMember extends StatefulWidget {
  @override
  _addState createState() => _addState() ;
}

class _addState extends State<AddMember> {

  String username , password , confirmpass ;
  var res ;
  String response ;
  bool responseav = false  ;

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
                        'Add member',
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


  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        body: ListView(
          children : <Widget> [
          search(),
          SizedBox(height: 55.0,),
          Container(
            height: 500.0,
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, childAspectRatio: 3.5),
              children: <Widget>[
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
               Padding(

                 padding : EdgeInsets.only(left: 25.0 , right: 25.0),
                 child : Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children : <Widget> [
                     Text('Confirm Password' , style: TextStyle( color : Colors.white , fontWeight: FontWeight.bold),),
                     SizedBox(height: 10.0,),
                   TextFormField(
                  obscureText: true,
                  style: TextStyle(
                    color: Colors.white,

                  ),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13.0)
                    ),
                    hoverColor: Colors.white,
                    hintText: 'confirm password' ,
                    hintStyle: TextStyle(
                      color: Colors.white54,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                  onChanged: (value) {
                    confirmpass = value ;
                  },
                ),
                     SizedBox(height: 10.0,)

                   ]
                ),
      ),
                Container(
                 padding: EdgeInsets.symmetric(vertical: 23.0 , horizontal: 70.0),
                child : FloatingActionButton.extended(
                 onPressed: () async {
                    if (password == confirmpass){
                      res = await registeruser(username , password) ;
                      setState(() {
                        response = res ;
                        responseav = true ;
                      });
                    }
                    else {
                      setState(() {
                        response = 'password confirmation failed' ;
                        responseav = true ;
                      });
                    }
                 },
                  backgroundColor: Theme.of(context).primaryColor,
                  icon: Icon(Icons.person_add),
                  label: Text('Add to family' , style: TextStyle(color : Colors.white , fontWeight: FontWeight.bold , fontSize: 16.0))
                )

                ),
          if (responseav) Text(
        response ,
        style: TextStyle( color: Colors.white),

      )

              ],
            ),
          ),
        ]
        ),
      );
  }
}