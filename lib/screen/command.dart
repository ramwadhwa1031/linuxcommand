import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:linuxcommand/animation/fadeanimation.dart';
import 'package:http/http.dart' as http;

class Command extends StatefulWidget {
  @override
  _CommandState createState() => _CommandState();
}

class _CommandState extends State<Command> {
  var tfcontroller= TextEditingController();
  var id;
  var output = " ";
  String command;
  var fs = FirebaseFirestore.instance;
  linuxCommand(command) async {
    var url = 'http://172.20.10.5/cgi-bin/linux.py?cmd=$command';
    var response = await http.get(url);
    var val;

    setState(() {
      val = response.body;
    });
    output = val;
    await fs.collection("RHEL8 Command").add({
      "command": command,
      "value": val,
    }).then((value) {
      id = value.id;
    });
    //print(db);

    print(id);
    //print(response.body);
    await fs.collection("RHEL8 Command").doc(id).get().then((value) {
      print(value.data()['value']);

      setState(() {
        output = value.data()['value'];
      }); //print(data);
    });

    //print(output.runtimeType);
    //print(id);
    //print(data.data().runtimeType);
    /*if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    print(jsonResponse);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }*/
  }

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
          children: [
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                    1.1,
                    Text("Run Linux Commands",
                      
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
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
                    child: Column(
                      children: [
                        SizedBox(height: 25),
                        FadeAnimation(
                            1.6,
                            Container(
                              color: Colors.white,
                              child: TextField(
                                controller: tfcontroller,
                                onChanged: (value) {
                                  command = value;
                                },
                                decoration: InputDecoration(
                                  labelText: "Enter command",
                                  hintText: "command",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(15.0),
                                  ),
                                ),
                              ),
                            )),
                        SizedBox(height: 30),
                        FadeAnimation(
                            2.1,
                            Container(
                              //color: Colors.blue,
                              //height: 60,
                              child: RaisedButton(
                                
                                color: Colors.blue,
                                  onPressed: () {
                                    tfcontroller.clear();
                                    linuxCommand(command);
                                  },
                                  child: Text(
                                    "Run Command",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            )),
                        new Expanded(
                            flex: 1,
                            child: new SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Container(
                                  margin: EdgeInsets.all(20),
                                  //color: Colors.black,
                                  //width: 450,
                                  //width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                   gradient: LinearGradient(colors: [
                                     //Colors.amberAccent,
                                     Colors.blueAccent,
                                    Colors.lightBlueAccent,
                                    //Colors.lime,
                                    //Colors.orange,
                                    Colors.lightGreenAccent,
                                   ],)
                                  ),
                                  child: Text(
                                    output ?? "",
                                    style: TextStyle(
                                      //color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            )),
                        Container(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
