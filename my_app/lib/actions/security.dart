import 'package:flutter/material.dart';



class LiveS extends StatefulWidget {
  @override
  VideoState createState() => VideoState();
}

class VideoState extends State<LiveS> {
  //static const plateform = const MethodChannel("com.flutter.epic/epic");FacebookLogin fb = new FacebookLogin() ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Center(
        child: IconButton(
            icon: Icon(Icons.view_stream)
            , onPressed: () {
                 // fb.logIn(['email']).then((result){

                 // });
            }),
      ),
    );
  }

  void stream() async {
    try {
     // await plateform.invokeMethod("stream") ;
    }
    catch(e){
      print(e);
    }
  }
}