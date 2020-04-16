import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:my_app/actions/music.dart';
import 'package:my_app/actions/security.dart';
import 'package:my_app/actions/lights.dart';
import 'package:my_app/utils/API.dart';
import 'package:my_app/utils/constants.dart';
import 'package:my_app/utils/Classes.dart';
import 'package:my_app/actions/doors.dart';
import 'package:my_app/actions/chat.dart';
import 'package:my_app/admin/admin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/utils/internalApis.dart';
import 'package:my_app/actions/login.dart';



class Home extends StatefulWidget {
  @override
  HomeState createState()  => HomeState();
}

class HomeState extends State<Home> {



  Future getusername() async {
    final prefs = await SharedPreferences.getInstance() ;
    return  prefs.getString('username') ?? 'none';
  }

  button() {
    return Material(
      // padding: new EdgeInsets.all(5.0),
      elevation: 0.5,
      shape: CircleBorder(),
      clipBehavior: Clip.hardEdge,
      color: Colors.transparent,
      child: Ink.image(
        image: AssetImage('assets/profile_default.jpg'),
        fit: BoxFit.cover,
        width: 80.0,
        height: 65.0,
        child: InkWell(
          onTap: () {},
        ),
      ),
    );


  }

  bool admin = false ;

  Future checkadmin() async {
    final prefs = await SharedPreferences.getInstance();
    bool temp = prefs.getBool('isadmin' ) ?? false ;
    setState(() {
      admin = temp ;
    });
  }




  // ______________SEARCH BAR ______________________


  String searchQuery ;

  List<Option> categories = new List<Option>(6) ;

  Option Lights_ = Option('Lights' , 'lightroute') ;
  Option Doors_ = Option('Doors' , 'doorsroute') ;
  Option Security = Option('Security' , 'securityroute') ;
  Option Temp_ = Option('Temperature' , 'temproute') ;
  Option Music_ = Option('Music' , 'musicroute') ;
  Option Chat_ = Option('Chat' , 'chatroute') ;


  void mapOptions () {
    categories = [] ;
    categories.add(Lights_) ;
    categories.add(Doors_) ;
    categories.add(Security) ;
    categories.add(Temp_) ;
    categories.add(Music_) ;
    categories.add(Chat_) ;
  }

  var image_encoded ;



  search() {
    mapOptions() ;
    Uint8List bytes_ = image_encoded ;
    //Uint8List bytes_ = BASE64.decode(bytes);
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
                      // backgroundImage: NetworkImage(gurl + 'static/pdp.jpg'),
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                        "Hi it's Lilia ! How can I help ?",
                        style: TextStyle(color: Colors.white,
                            fontSize: 18, fontWeight: FontWeight.bold )
                    ),

                  ],
                ),
                IconButton(
                  icon: Icon(
                    Icons.business_center,
                    color: Colors.white,

                  ),
                  onPressed : () async  {
                    await checkadmin();
                    if(admin)
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Adminroute()),
                      );

                  } ,
                ),

              ],
            ),
            SizedBox(height: 30.0) ,
            TextField(
              decoration: InputDecoration(
                hintText: "Search" ,
                fillColor: Colors.white,
                filled: true,
                suffixIcon: IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () {
                    for(int i = 0 ; i < 6 ; i++){
                      if(searchQuery == categories[i].optionName){
                        print(categories[i].destination) ;
                      }
                    }
                  },
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.transparent,),
                ),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0
                ),
              ),
              onChanged: (value) {
                searchQuery = value ;
              },
            )
          ]
      ),
    );
  }



  // _____________________GRID ______________________


  gridItem(icon,text, dest) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        CircleAvatar(
          radius: 30.0,
          child: IconButton(
            icon : Icon(icon),
            color: Colors.white,
            onPressed: () async {
              if (dest == 'chatroute'){


                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => chatroute()
                    )
                );

              }
              else if (dest == 'lightroute'){
                var username =  await getusername () ;
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Lights(username)
                    )
                );
              }
              else if (dest == 'doors'){
                var username =  await getusername () ;
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => doors(username)
                    )
                );
              }
              else if (dest == 'music'){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Music()
                    )
                );
              }
              else if (dest == 'liveS'){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LiveS()
                    )
                );
              }

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




  Widget build(BuildContext context){
    return
      Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        body: homeFunc(),
        bottomNavigationBar: BottomNavigationBar(items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
          )
        ],
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).primaryColor,
          onTap: _onItemTapped,
          backgroundColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.grey,
          elevation: 10,
        ),

      );
  }

  int _selectedIndex = 0 ;
  _onItemTapped(index){
    setState(() {
      _selectedIndex = index ;
    });

  }

  homeFunc() {
    if(_selectedIndex == 0) return FutureBuilder(
        future: homebuilder(),
        builder: (BuildContext context , AsyncSnapshot snap){
          if(snap.data != 1 && snap.data != -1) { return Column(
            mainAxisAlignment : MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.green)),
                ],
              ),
              SizedBox(height: 15.0,),
              Text(''
                  'loading home data ..' , style: unistyle,)
            ],
          ) ;  }
          else if(snap.data == -1){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Expanded(
                    child: Container(
                        child: Login()
                    )
                ),
              ],
            );
          }
          else
          return ListView(
              children : <Widget> [
                search(),
                SizedBox(height: 15.0,),
                Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Categories",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold , color: Colors.white),
                        ),
                      ],
                    )
                ),
                SizedBox(height: 10.0,),
                Container(
                    height: 400.0,
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 5/3),
                      children: <Widget>[
                        gridItem(Icons.lightbulb_outline,"Lights",'lightroute'),
                        gridItem(Icons.close, "Doors",'doors'),
                        gridItem(Icons.security, "Security",'liveS'),
                        gridItem(Icons.hot_tub, "Temperature",'none'),
                        gridItem(Icons.music_note, "Music",'music'),
                        gridItem(Icons.chat_bubble, "chat",'chatroute'),
                      ],)
                )
              ]
          );
        }
    );
    else if(_selectedIndex == 1){
      return Column(
        children: <Widget>[
          AppBar(
            leading: Icon(Icons.arrow_back_ios),
            title: Text('Settings' , style : unistyle),
          ),
          Expanded(
            child: Container(
              child: ListView(
                padding: const EdgeInsets.all(9),
                children: <Widget>[
                  Container(
                    height: 80,
                    child:  Row(
                        children:
                        <Widget>[
                          Text('  Switch Account' ,
                            style: smallText,)
                        ] ),
                  ),
                  GestureDetector(
                    onTap: (){
                        logout() ;
                    },
                    child: Container(
                      height: 80,
                      child:  Row(
                          children:
                          <Widget>[
                            Text('  Disconnect' ,
                              style: smallText,)
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
                          children:
                          <Widget>[
                            Text('  Display and Ui' ,
                              style: smallText,)
                          ] ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){

                    },
                    child: Container(
                      height: 80,
                      child:  Row(
                          children:
                          <Widget>[
                            Text('  Learn More ..' ,
                              style: smallText,)
                          ] ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );

    }
  }
}