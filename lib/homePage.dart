import 'dart:math';
import 'package:database/dbHelper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DbHelper dbHelper=DbHelper.getInstance();

  var titleController =TextEditingController();
  var descController =TextEditingController();
  List<Map< String, dynamic>> mData=[];
 //String dueDate='';
 bool isCheck=false;

 ///  variablre date formate with pakage (intl)
 //DateFormat dateFormat=DateFormat.MMMEd();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void  getNotes()async{
  mData= await dbHelper.fectNote();
  setState(() {});
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         centerTitle: true,
         title: Text('Home Page'),
       ),
       body: mData.isNotEmpty ?  ListView(
         children: [

           SizedBox(
             height: 100,
             child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
               crossAxisCount:2,
               childAspectRatio: 5/5,
               crossAxisSpacing: 2,
               mainAxisSpacing: 2,
             ),itemCount: mData.length,
               itemBuilder: (context, index) =>Container(
                 height:100 ,
                 width: double.infinity,
                 decoration: BoxDecoration(
                   color: Colors.primaries[Random().nextInt(Colors.primaries.length,)]
                 ),
                 child: Column(
                   children: [

                     Row(
                       children: [
                        Checkbox(value: isCheck, onChanged:(value){
                          isCheck=true;
                          setState(() {});
                        },),

                         SizedBox(
                           width: 11,
                         ),

                         Text(mData[index][DbHelper.NOTE_COLUMN_TITLE]),
                       ],
                     ),
                     SizedBox(
                       height: 11,
                     ),

                     Text(mData[index][DbHelper.NOTE_COLUMN_DESC]),

                     SizedBox(
                       height: 11,

                     ),

                    //  Text(mData[index][DbHelper.NOTE_COLUMN_CREATED_AT]),

                     Row(
                       children: [
                         InkWell(
                           onTap: (){
                             titleController.text=mData[index][DbHelper.NOTE_COLUMN_TITLE];
                             descController.text=mData[index][DbHelper.NOTE_COLUMN_DESC];

                             showModalBottomSheet(context: context, builder: (context) {
                             return getSheetButtom(isUpdate: true ,matchID: mData[index][DbHelper.NOTE_COLUMN_ID]);
                             },);

                           },
                           child: Icon(Icons.edit),
                         ),

                         SizedBox(
                           width: 11,
                         ),

                         InkWell(
                           onTap: ()async{
                            bool check=await dbHelper.deletNote(deletID:mData[index][DbHelper.NOTE_COLUMN_ID]);
                           if (check){
                             getNotes();
                           }

                            },
                           child: Icon(Icons.delete),
                         ),
                       ],
                     )
                   ],
                 ),
               )  ),
           )
         ]
       ):
       Center(child: Text('Not Add Note')),

        floatingActionButton: FloatingActionButton(onPressed: (){
          titleController.clear();
          descController.text='';
          showModalBottomSheet(context: context, builder: (_)=>
          getSheetButtom());
        },child: Text('Note',textAlign: TextAlign.center,),),

     );
  }

  Widget getSheetButtom({isUpdate = false, int matchID=0}){
    return Container(
      height: 350,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white70,
      ),

      child: Column(
        children: [
          Text('Add Note',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),

          SizedBox(
            height: 11,
          ),

          TextField(
            controller: titleController,
          ),

          SizedBox(
            height: 11,
          ),

         // Date Time:
         //  SizedBox(
         //    width: 100,
         //    child: OutlinedButton(onPressed:  ()async{
         //      DateTime? selecteDate=await showDatePicker(context: context,
         //          firstDate: DateTime.now(),
         //          lastDate: DateTime(9999));
         //    //  print(selecteDate!. millisecondsSinceEpoch.toString());
         //      dueDate=selecteDate!.millisecondsSinceEpoch.toString();
         //    }, child: Text("Date")),
         //  ),

          TextField(
            controller: descController,
          ),

          SizedBox(
            height: 11,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(onPressed: ()async{
                if(titleController.text.isNotEmpty && descController.text.isNotEmpty){

                  if(isUpdate){
                    bool check= await dbHelper.updateNote(
                        title: titleController.text,
                        desc: descController.text,
                        updateId:matchID);
                    if(check){
                      getNotes();
                      Navigator.pop(context);
                    }
                  }
                  else{
                    bool check=await dbHelper.addNote(
                        title: titleController.text,
                        desc: descController.text,
                       // date: dueDate
                    );
                    if(check){
                      getNotes();
                      Navigator.pop(context);
                    }
                  }
                } else{
                  Navigator.pop(context);
                }

              }, child: Text('Add')),

              SizedBox(
                width: 11,
              ),

              OutlinedButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text('Cancel')),
            ],
          )
        ],
      ),
    );
  }



}