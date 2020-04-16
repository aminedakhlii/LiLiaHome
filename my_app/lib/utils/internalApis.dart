import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/utils/API.dart';


void logout() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('islogged', false) ;
  prefs.setBool('isadmin', false) ;
}
Future setlogged(username) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('islogged', true);
  prefs.setString('username', username) ;
}
Future setloggedasadmin() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('isadmin', true);
}

void login(username , password) async {
  var res = await loginuser(username, password) ;
  String currentid = res ;
  if (res != '0') {
    if(res == '1')
    setloggedasadmin() ;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('my_id', currentid) ;
    setlogged(username) ;
  }
}

Future loggedornot() async {
  final prefs = await SharedPreferences.getInstance();
  bool ret = prefs.getBool('islogged') ?? false ;
  bool admin = prefs.getBool('isadmin') ?? false ;
    if(ret == true) {
      if (admin == true)
        {
          return  1 ;
        }
      else {
        return  2 ;
      }
    }
    else {
      return 0;
    }

}

Future my_id() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('my_id') ?? '0' ;
}

void saveLastUrl() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('lastGurl', gurl) ;
}

Future getLastUrl() async {
  final prefs = await SharedPreferences.getInstance();
  return  prefs.getString('lastGurl') ?? 'none';
}