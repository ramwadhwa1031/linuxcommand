import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:linuxcommand/animation/fadeanimation.dart';
import 'package:linuxcommand/screen/command.dart';
import 'package:linuxcommand/screen/login.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var authc = FirebaseAuth.instance;
  String email;
  String password;
  bool ssloader = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: ssloader,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Color(0xFFF206ffd),
              Color(0xFFF3280fb),
              Color(0xFFF28c3eb)
            ])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 80),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FadeAnimation(
                        1.1,
                        Text("Welcome Back",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold)),
                      ),
                      FadeAnimation(
                          1.3,
                          Text("Register to Super Admin",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18))),
                    ],
                  ),
                ),
                SizedBox(height: 35),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFFf4f7fc),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(35),
                          topLeft: Radius.circular(35))),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child: Column(children: [
                        SizedBox(height: 30),
                        FadeAnimation(
                            1.6,
                            Container(
                              color: Colors.white,
                              child: TextField(
                                onChanged: (value) {
                                  email = value;
                                },
                                decoration: InputDecoration(
                                  labelText: "Enter Email",
                                  hintText: "email",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(15.0),
                                  ),
                                ),
                              ),
                            )),
                        SizedBox(height: 20),
                        FadeAnimation(
                            1.9,
                            Container(
                              color: Colors.white,
                              child: TextField(
                                obscureText: true,
                                onChanged: (value) {
                                  password = value;
                                },
                                decoration: InputDecoration(
                                  labelText: "Enter Password",
                                  hintText: "password",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(15.0),
                                  ),
                                ),
                              ),
                            )),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FadeAnimation(
                              2.2,
                              RichText(
                                text: TextSpan(
                                  //style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Existing User?',
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 20),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Login()),
                                            );
                                          }),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 30),
                        FadeAnimation(
                            2.5,
                            Container(
                              //color: Colors.blue,
                              //height:60,

                              child: RaisedButton(
                                  color: Colors.blue,
                                  onPressed: () async {
                                    setState(() {
                                      ssloader = true;
                                    });
                                    try {
                                      var user = await authc
                                          .createUserWithEmailAndPassword(
                                              email: email, password: password);
                                      if (user.additionalUserInfo.isNewUser ==
                                          true) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Command()),
                                        );
                                      }
                                      print(user);
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            )),
                      ]),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
