
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static SharedPreferences ?sharedPreferences;

  static init() async{
    sharedPreferences = await SharedPreferences.getInstance();
  }
  static Future<bool> putData(String key,dynamic value)async{
    if(value is String){
      return await sharedPreferences!.setString(key, value);
    }else if(value is bool){
      return await sharedPreferences!.setBool(key, value);
    }else{
      return await sharedPreferences!.setInt(key, value);
    }
  }

  static Future<bool> removeData(String key)async{
    return await sharedPreferences!.remove(key);

  }


  static dynamic getData(String key){
    return sharedPreferences!.get(key);
  }

}