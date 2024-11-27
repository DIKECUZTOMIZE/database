import 'dart:math';
import 'package:database/dbHelper.dart';
import 'package:database/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DbHelper dbHelper = DbHelper.getInstance();

  var titleController = TextEditingController();
  var descController = TextEditingController();
  List<NoteModel> mData = [];
  String dueDate='';
  DateFormat dtFormat=DateFormat.MMMEd();

  List<Color> myColors=[
    Colors.green,
    Colors.orange,
    Colors.blueAccent,
    Colors.purple,
    Colors.yellowAccent,
    Colors.lightGreen,
    Colors.greenAccent,
    Colors.lightGreenAccent,
    Colors.purpleAccent,
    Colors.teal,
  ];
  ///  variablre date formate with pakage (intl)
  //DateFormat dateFormat=DateFormat.MMMEd();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void getNotes() async {
    mData = await dbHelper.fectNote();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
      backgroundColor: Colors.white12,
        title: Text('My Note',style: TextStyle(color: Colors.white70,fontWeight:FontWeight.bold,
        fontSize: 30),),
      ),
      body: mData.isNotEmpty
          ? ListView(children: [
              SizedBox(
                height: 900,
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 5 / 6,
                    
                    ),
                    itemCount: mData.length,
                    itemBuilder: (context, index) => Padding(padding: EdgeInsets.all(5),
                      child: Container(
                        padding: EdgeInsets.all(21),
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius:BorderRadius.all(Radius.circular(21)),
                                color:myColors[myColors.length-1]
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween
                                  ,
                                  children: [
                                    Text(mData[index].tilte,style: TextStyle(
                                      fontSize: 25,color: Colors.black
                                    ),),
                      
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            titleController.text = mData[index].tilte;
                                            descController.text = mData[index].desc;
                      
                                            showModalBottomSheet(context: context, builder: (context) {
                                              return getSheetButtom(isUpdate: true, ID: mData[index].id!);
                                            },
                                            );
                                          },
                                          child: Icon(Icons.edit,color: Colors.white,),
                                        ),
                                        SizedBox(
                                          height: 11,
                                        ),

                                        InkWell(
                                          onTap: () async {
                                            bool check = await dbHelper.deletNote(
                                                deletID: mData[index].id!);
                                            if (check) {
                                              getNotes();
                                            }
                                          },
                                          child: Icon(Icons.delete,color: Colors.red,),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 11,
                                ),
                      
                                Text(mData[index].desc,style: TextStyle(color:Colors.black,
                                fontSize: 20),),

                                SizedBox(
                                  height: 11,
                                ),

                                Text(dtFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(mData[index].created_at)))) ,
                      
                              ],
                            ),
                          ),
                    )),
              )
            ])
          : Center(child: Text('Not Add Note')),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          titleController.clear();
          descController.text = '';
          showModalBottomSheet(context: context, builder: (_) => getSheetButtom());
        },
        child: Text(
          'Note',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget getSheetButtom({isUpdate = false, int ID = 0}) {
    return Container(
      height: 350,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white70,
      ),
      child: Column(
        children: [

          Text(
            isUpdate ?'Update Note':'Add Note',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),

          SizedBox(
            height: 11,
          ),

          TextField(
            controller: titleController,
          ),

          SizedBox(
            height: 11,
          ),

          SizedBox(
            width: 100,
            child: OutlinedButton(onPressed: ()async{
             DateTime? selected=await showDatePicker(context: context,
                  firstDate:DateTime.now(),
                  lastDate: DateTime(9999));
             print(selected!.millisecondsSinceEpoch.toString());
              dueDate= selected.millisecondsSinceEpoch.toString();
            } , child:Text('Date')),
          ),

          TextField(
            controller: descController,
          ),

          SizedBox(
            height: 11,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                  onPressed: () async {
                    if (titleController.text.isNotEmpty && descController.text.isNotEmpty) {
                      bool check=false;

                      if (isUpdate) {
                        check = await dbHelper.updateNote(
                            title: titleController.text,
                            desc: descController.text,
                            updateId: ID);
                        }
                        else {
                         check = await dbHelper.addNote(NoteModel(
                            tilte: titleController.text,
                            desc: descController.text,
                            created_at:dueDate ,
                         ));
                        }

                        if(check){
                          Navigator.pop(context);
                          getNotes();
                        }
                    }
                  },
                  child: Text(isUpdate ? 'Upadte':'Add')),
              SizedBox(
                width: 11,
              ),

              OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
            ],
          )
        ],
      ),
    );
  }
}
