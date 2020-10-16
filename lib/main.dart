import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        accentColor: Colors.cyan),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String studentName, studentId, studyProgramId;
  double studentGPA;

  getStudentName(name) {
    this.studentName = name;
  }

  getStudentId(id) {
    this.studentId = id;
  }

  getStudyProgramId(programId) {
    this.studyProgramId = programId;
  }

  getStudentGPA(gpa) {
    this.studentGPA = double.parse(gpa);
  }

  createData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyStudent").doc(studentName);

    //create map
    Map<String, dynamic> students = {
      "studentName": studentName,
      "studentId": studentId,
      "studyProgramId": studyProgramId,
      "studentGPA": studentGPA
    };

    documentReference.set(students).whenComplete(() {
      print("$studentName created");
    });
  }

  readData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyStudent").doc(studentName);

    documentReference.get().then((datasnapshot) {
      print(datasnapshot.data()['studentName']);
      print(datasnapshot.data()["studentId"]);
      print(datasnapshot.data()["studyProgramId"]);
      print(datasnapshot.data()["studentGPA"]);
    });
  }

  updateData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyStudent").doc(studentName);

    //create map
    Map<String, dynamic> students = {
      "studentName": studentName,
      "studentId": studentId,
      "studyProgramId": studyProgramId,
      "studentGPA": studentGPA
    };

    documentReference.set(students).whenComplete(() {
      print("$studentName updated");
    });
  }

  deleteData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyStudent").doc(studentName);

    documentReference.delete().whenComplete(() {
      print("$studentName deleted");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My College Companion"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Name",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String name) {
                  getStudentName(name);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Student ID",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String id) {
                  getStudentId(id);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Student Program ID",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String programId) {
                  getStudyProgramId(programId);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "GPA",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
                onChanged: (String gpa) {
                  getStudentGPA(gpa);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.greenAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Text("Create"),
                    textColor: Colors.white,
                    onPressed: () {
                      createData();
                    },
                  ),
                  RaisedButton(
                    color: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Text("Read"),
                    textColor: Colors.white,
                    onPressed: () {
                      readData();
                    },
                  ),
                  RaisedButton(
                    color: Colors.orangeAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Text("Update"),
                    textColor: Colors.white,
                    onPressed: () {
                      updateData();
                    },
                  ),
                  RaisedButton(
                    color: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Text("Delete"),
                    textColor: Colors.white,
                    onPressed: () {
                      deleteData();
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                textDirection: TextDirection.ltr,
                children: <Widget>[
                  Expanded(
                    child: Text("Name"),
                  ),
                  Expanded(
                    child: Text("Student ID"),
                  ),
                  Expanded(
                    child: Text("Program ID"),
                  ),
                  Expanded(
                    child: Text("GPA"),
                  ),
                ],
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("MyStudent")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot documentSnapshot =
                          snapshot.data.documents[index];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(documentSnapshot["studentName"]),
                            ),
                            Expanded(
                              child: Text(documentSnapshot["studentId"]),
                            ),
                            Expanded(
                              child: Text(documentSnapshot["studyProgramId"]),
                            ),
                            Expanded(
                              child: Text(
                                  documentSnapshot["studentGPA"].toString()),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
