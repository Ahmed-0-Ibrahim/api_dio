import 'package:api_dio/Constants.dart';
import 'package:api_dio/Network/Local/Cache_helper.dart';
import 'package:api_dio/Network/Remote/Dio_helper.dart';
import 'package:api_dio/Screen/Home.dart';
import 'package:api_dio/Screen/Login.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Static.TOKEN = CacheHelper.getData('token');
  var re;
  if (Static.TOKEN != null) {
    re = await DioHelper.getData(endPoint: PROFILE, token: Static.TOKEN);
    print(re);
  }
  runApp(Static.TOKEN != null?MyApp(
    name: re.data['data']['name'],
    phone: re.data['data']['phone'],
    email: re.data['data']['email'],
  ):MyApp());
}

class MyApp extends StatelessWidget {
  String? name, phone, email;

  MyApp({Key? key, this.name, this.phone, this.email}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'API',
      home: Static.TOKEN == null ? Login() : Home(name: name,phone:  phone, email: email),
      // home:Login(),
    );
  }
}
