import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ReminderBox extends StatefulWidget {
  final String task;
  ReminderBox({Key? key ,required this.task}):super(key: key);


  @override
  _ReminderBoxState createState() => _ReminderBoxState();
}

class _ReminderBoxState extends State<ReminderBox> {
  Color containerColor = Colors.lightBlue.shade100;

  Icon checkbox1 = Icon(Icons.check_box_outline_blank,color: Colors.blueGrey);
  bool status=false;
  void changeCheckbox(bool status){
    setState(() {

      if(status== false){ //If false means task not done
        //And when you click the checkbox the task is done
        checkbox1 = Icon(Icons.check_box,color: Colors.green,);
        containerColor=Colors.green.shade100;
        this.status=true;
      }
      else{
        checkbox1 = Icon(Icons.check_box_outline_blank,color: Colors.blueGrey);
        containerColor = Colors.lightBlue.shade100;
        this.status=false;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
            child: IconButton(
                onPressed: (){ changeCheckbox(status);},
                icon: checkbox1,
            )
        ),
        Expanded(
          flex:10,
          child: Container(
            margin: EdgeInsetsDirectional.fromSTEB(5, 15, 10, 10),
            padding: EdgeInsetsDirectional.all(15),
            child: Text(widget.task,style: TextStyle(fontSize: 25),),
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ],
      )
    ;
  }
}
