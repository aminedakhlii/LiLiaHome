import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:my_app/utils/internalApis.dart';



String gurl ;

Future homebuilder() async {
  var ret1 = await gurltest() ;
  var ret2 = await loggedornot();
  if(ret2 != 0 && ret1 == 1)
    return 1 ;
  else if(ret2 == 0)
    return -1 ;

}

Future gurltest() async{
  if (gurl == null) {
    print('null');
    String glast;
    glast = await getLastUrl();
    if (glast != 'none' && glast != null) {
      print('testing last' + glast) ;
      try {
        http.Response testUrl = await http.post(glast).timeout(
            Duration(seconds: 3));
        if (testUrl.body == '98224148') {
          print('last worked');
          gurl = glast;
          return 1;
        }
      }
      catch(e) {
        print('searching');
        var ret = await fillGurl();
        await saveLastUrl();
        return 1;
      }
    }
  }

    else {
      return 1 ;
    }

}


Future fillGurl() async {
  for (var interface in await NetworkInterface.list()) {
    print('== Interface: ${interface.name} ==');
    for (var addr in interface.addresses) {
      print(
          '${addr.address} ${addr.host} ${addr.isLoopback} ${addr.rawAddress} ${addr.type.name}');
      String default_ = 'http://' + addr.rawAddress[0].toString()+ '.' + addr.rawAddress[1].toString() +
                        '.' + '1' + '.';
      for(int i = 2 ; i < 256 ; i++) {
        print(i) ;
        try {
          print(default_ + i.toString() + ':9877/') ;
          http.Response testUrl =  await http.post(default_ + i.toString() + ':9877/').timeout(Duration(seconds: 3)) ;
          print(testUrl.body) ;
        if (testUrl.body == '98224148'){
          gurl = default_ + i.toString() + ':9877/' ;
          await saveLastUrl() ;
          print(default_ + i.toString() + ':9877/');
          return 1 ;
        }
        }
        catch(e) { print(e) ;
        continue ; }

      }
    }
  }
  return -1 ;
}

Future api( val) async {
  http.Response Response = await http.post(gurl + 'lilia' , body : {'q' : val });
  return Response.body ;
}

Future loginuser( username,password) async {
  http.Response Response = await http.post(gurl + 'login' , body: { 'username' : username , 'password' : password }) ;
  return Response.body ;
}

Future testlogin() async {
  http.Response Response = await http.post(gurl + 'test' , body: { 'p' : '1' }) ;
  return Response.body ;
}

Future get_number() async {
  http.Response Res = await http.post(gurl + 'getnum' , body: { 'n' : '1' });
  return Res.body ;
}

Future get_all_members() async {
  http.Response Res = await http.post(gurl + 'getnum' , body: { 'n' : '0' , 'username' : 'none' });
  return Res.body ;
}

Future get_userid(name) async {
  http.Response Res = await http.post(gurl + 'getnum' , body: { 'username' : name , 'n' : '0' });
  return Res.body ;
}

Future getPP(id) async {
  http.Response Res = await http.post(gurl + 'profile_pic' , body: { 'id' : id});
  return Res.body ;
}


Future registeruser(username, password) async {
  http.Response Response = await http.post(gurl + 'admin' , body: { 'logged' : 'true' , 'id' : '1' ,'adduser':'add' ,'username' : username , 'password' : password }) ;
  return Response.body ;
}

Future get_chats_list(id) async {
  http.Response res = await http.post(gurl + 'chatsdata', body: { 'current_user' : id } ) ;
    return res.body ;
}

Future get_messages(friendid , me) async {
  http.Response res = await http.post(gurl + 'send_message' , body: { 'message' : 'voidmessagevoidmessagevoidmessage',
  'partner' : friendid , 'current_user' : me}  ) ;
  return res.body;
}

Future send_message(message , me , friend) async {
  http.Response res = await http.post(gurl + 'send_message' , body: {'message' : message ,
  'partner' : friend , 'current_user' : me }) ;
  return res.body ;
}






// -------------------- Home Actions --------------------- //

Future opendoor() async {

    http.Response res = await http.post(gurl + 'lilia' , body: { 'q' : 'python open.py' });
    return res.body ;

}
Future closedoor() async {
  http.Response res = await http.post(gurl + 'lilia' , body: { 'q' : 'python close.py' });
  return res.body ;
}