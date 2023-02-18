import 'package:chat_app/moduls/home/home.dart';
import 'package:chat_app/moduls/login/Login_view.dart';
import 'package:chat_app/moduls/signUp/signUp.dart';
import 'package:chat_app/moduls/splachScreen.dart';
import 'package:chat_app/provider/my_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'moduls/add_room/add-room-screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      ChangeNotifierProvider(
          create: (context) => MyProvider(),
          child: MyApp()));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return MaterialApp(
      initialRoute: provider.firebaseUser != null ? HomeScreen.routeName
          : LoginScreen.routeName,
      routes: {
        LoginScreen.routeName:(context)=>LoginScreen(),
        SignUpScreen.routeName:(context)=>SignUpScreen(),
        HomeScreen.routeName:(context)=>HomeScreen(),
        AddRoomScreen.routeName:(context)=>AddRoomScreen(),
      },
      debugShowCheckedModeBanner: false,
      home: SplachScreen(),
    );
  }
}
