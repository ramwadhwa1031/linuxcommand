import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linuxcommand/screen/command.dart';
import 'package:linuxcommand/screen/login.dart';
import 'package:linuxcommand/screen/registeration.dart';
import 'package:linuxcommand/screen/splash.dart';

void main() async { 
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  title: "Login Screen",
  theme: ThemeData(
    primarySwatch: Colors.blue,
  ),
  //home: Login(),
  initialRoute: "/",
  routes: {
    
    "/" :(context) => Splash(),
    "login" : (context) => Login(),
    "command" : (context) => Command(),
    "register" : (context) => Register(),
  },
));
}
