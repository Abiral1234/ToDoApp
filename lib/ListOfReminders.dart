import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/screens/wrapper.dart';
import 'package:todoapp/services/authentication.dart';
import 'customWidgets/ReminderBox.dart';
import 'customWidgets/calender.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

class ListOfReminders extends StatefulWidget {
  //final String email;
  //const ListOfReminders({ required Key key,required this.email }): super(key: key);

  @override
  _ListOfRemindersState createState() => _ListOfRemindersState();
}

class _ListOfRemindersState extends State<ListOfReminders> {
  int i=0,j=0,fieldLength=0;
  String instruction ='What do you like to do ?';
  String taskFromFirebase='';
  String task='';
  List<ReminderBox> boxes =[];
  final myController = TextEditingController();
  String email='';
  Map<String ,dynamic> data={
    "null" : "null"
  };
  //Initializing Firebase App

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  
  //DocumentReference UserTask = .doc('User1');
  
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> addUserTaskToFirebase(String doneTask){
    i++;
    return FirebaseFirestore.instance.collection('SignedUser').doc('$email').set({
      'Task$i' : doneTask
    },SetOptions(merge: true));
  }

  //   final Stream<QuerySnapshot> taskStream = FirebaseFirestore.instance.collection('tasks').snapshots();
  //  final Stream<DocumentSnapshot<Map<String, dynamic>>> _usersStream = FirebaseFirestore.instance.collection('tasks').doc('$email').snapshots();


   updateNumberOfFields() {
    return FirebaseFirestore.instance
        .collection('SignedUser')
        .doc('$email')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      data = documentSnapshot.data() as Map<String ,dynamic>;
      fieldLength = data.length;
      print('No of Field $fieldLength');
    });
    }


   getTaskFromFirebase() async {
    FirebaseFirestore.instance
       .collection('SignedUser')
       .doc('$email')
       .get()
       .then((DocumentSnapshot documentSnapshot) {
      data = documentSnapshot.data() as Map<String ,dynamic>;
      print('The Values are: ${data.values}');
   }
   );
 }
  addReminderBox(){
    for(i=0;i<fieldLength;i++) {
      boxes.add(new ReminderBox(task: '${data.values.elementAt(i)}'));
    }
    setState((){
    });
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    if(firebaseUser != null){
      //print('The user is :${firebaseUser.email}');
      setState(() {
        email = firebaseUser.email!;
      });
    }
   setState(() {
     updateNumberOfFields();
     getTaskFromFirebase();
     addReminderBox();
     print('The data is : ${data.values}');
     print('Box Length ${boxes.length}');
   });
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do ',style: TextStyle(color: Colors.black87),),
        backgroundColor: Colors.white,
        leading: Icon(Icons.line_weight ,color: Colors.black87 ,),
        actions: [
          IconButton(
            icon : Icon(Icons.logout,color: Colors.black87,),
            onPressed: (){
              context.read<AuthenticationService>().signOut();
              Navigator.of(context).pushNamed('/SignIn');
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.blue.shade50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [

            Flexible(
              flex: 10,
             child: new ListView.builder(
                 itemCount : fieldLength,
                 itemBuilder: (_,index)=> boxes[index]),
               ),
            CalenderBox(),
            TextField(
              controller: myController,
                    decoration: InputDecoration(
                     focusColor: Colors.green,
                      labelText: '$instruction',
                    ),
              onSubmitted: (value){
                setState(() {
                addUserTaskToFirebase(value);
                      task=value;
                      print('Output Text: $task');
                      });
                myController.clear();
                      },
                  ),
            Row(
              children: [
              Expanded(child: IconButton(onPressed: (){}, icon: Icon(Icons.calendar_today_outlined))),
                Expanded(child: IconButton(onPressed: (){}, icon: Icon(Icons.timer))),
                Expanded(child: IconButton(onPressed: (){}, icon: Icon(Icons.flag))),
              ],
            ),
              ],
        ),
      ),
    );
  }
}

/* To Do:
  upto now the tasks are stored in cloud store
  but not shown from cloud store

 */
