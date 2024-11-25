import 'dart:math';

import 'package:database/dbHelper.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  DbHelper dbHelper=DbHelper.getInstance();
  List<Map<String , dynamic>> myData=[];

  var titleController=TextEditingController();
  var descController=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotes();
  }
  void getNotes()async{
      myData = await dbHelper.fectNote();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        centerTitle: true,
        title: Text('My Note',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
      ),

      body:myData.isNotEmpty ? GridView.builder(gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:2 ,
          childAspectRatio:5/3 ,
          mainAxisSpacing:3 ,
          crossAxisSpacing:2 ,),
          itemCount: myData.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(


              height: 100,
              decoration: BoxDecoration(
                  color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                borderRadius: BorderRadius.circular(21)
              ),

              child: ListTile(
                title: Text(myData[index][DbHelper.NOTE_COLUMN_TITLE],style: TextStyle(
                  color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500
                ),),
                subtitle: Text(myData[index][DbHelper.NOTE_COLUMN_DESC],style: TextStyle(
                  color: Colors.white.withOpacity(.7)
                ),),


                trailing: Container(

                  width: 100,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: (){
                          titleController.text=myData[index][DbHelper.NOTE_COLUMN_TITLE];
                          descController.text=myData[index][DbHelper.NOTE_COLUMN_DESC];
                          showModalBottomSheet(
                            enableDrag: true,
                            shape:  RoundedRectangleBorder(borderRadius: BorderRadius.vertical(
                              top: Radius.circular(21)
                            )),
                            context: context, builder: (_) {
                             return getSheetShow(isUpdate: true, nId: myData[index][DbHelper.NOTE_COLUMN_ID]);
                          },);
                        },
                        child: Icon(Icons.edit,color: Colors.white70,size: 20,),
                      ),


                      InkWell(
                        onTap: ()async{

                          showModalBottomSheet(context: context, builder: (context) =>
                           Container(
                             padding: EdgeInsets.all(21),
                             height: 100,
                             width: double.infinity,
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.end,
                               children: [

                                 OutlinedButton(onPressed: ()async{

                                   bool check=await dbHelper.deletNote(deletID: myData[index][DbHelper.NOTE_COLUMN_ID]);
                                   if(check){
                                     getNotes();
                                     Navigator.pop(context);
                                   }
                                 }, child: Text('Confrom')),

                                 SizedBox(
                                   width: 11,
                                 ),
                                 OutlinedButton(onPressed: (){
                                   Navigator.pop(context);
                                 }, child: Text('Cancel'))

                               ],
                             ),
                           ),

                          );

                        },
                        child: Icon(Icons.delete,color:Colors.red,size: 20,),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),):
      Center(child: Text("note not add")),

      floatingActionButton: FloatingActionButton(onPressed:(){

        titleController.clear();
        descController.clear();

        showModalBottomSheet(
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top:
         Radius.circular(21))),
          enableDrag: false,
          context: context, builder:(_) {
          return  getSheetShow();
        },);

      },child: Text('Add'),),
    );
  }

  Widget getSheetShow({isUpdate =false ,int nId =0}){

   return Container(
     height: 350,
      padding: EdgeInsets.all(21),
      width: double.infinity,

     decoration: BoxDecoration(
       color: Colors.white,
       borderRadius: BorderRadius.vertical(top: Radius.circular(21))
     ),
      child:Column(
        children: [
          Center(child: Text(isUpdate ? 'Update':'Add Note',style: TextStyle(
            fontSize: 30,fontWeight: FontWeight.bold,color: Colors.green
          ),)),

          SizedBox(
            height:  11,
          ),

          TextField(
            controller: titleController,
            //textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: 'Enter name',
              label: Text('*name'),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(21)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(21)),
            ),
          ),

          SizedBox(
            height:  11,
          ),

          TextField(
            minLines: 4,
            maxLines: 4,
            // textAlign: TextAlign.center,
            controller: descController,
            //   textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: 'Enter dese',
              label: Text('*desc'),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(21)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(21)),
            ),
          ),

          SizedBox(
            height:  11,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              OutlinedButton(onPressed: ()async {
                if (titleController.text.isNotEmpty && descController.text.isNotEmpty)
                {

                  bool check=false;
                  if(isUpdate){
                    check=await dbHelper.updateNote(
                        title:titleController.text.toString(),
                        desc:descController.text.toString(),
                        id: nId);


                  }else{
                    check =await dbHelper.addNote(
                        title: titleController.text.toString(),
                        desc: descController.text.toString());
                    getNotes();
                  }

                  if(check){
                    Navigator.pop(context);
                    getNotes();
                    }

                  // if(isUpdate){
                  //   bool check=await dbHelper.updateNote(
                  //       title: titleController.text.toString(),
                  //       desc: descController.text.toString(),
                  //       id: nId);
                  //
                  //   if(check){
                  //     getNotes();
                  //     Navigator.pop(context);
                  //   }
                  //   else{
                  //
                  //     Navigator.pop(context);
                  //   }
                  // }
                  // else {
                  //   bool check = await dbHelper.addNote(
                  //       title: titleController.text.toString(),
                  //       desc: descController.text.toString(),
                  //       );
                  //
                  //   if(check){
                  //     getNotes();
                  //     Navigator.pop(context);
                  //   }
                  //   else{
                  //
                  //     Navigator.pop(context);
                  //   }
                  //
                  //
                  // }



                }else {
                  Navigator.pop(context);
                }
                
              },child: Text(isUpdate? 'update':'Add')),


              SizedBox(
                width: 11,
              ),
              OutlinedButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text('Cancel'))
            ],
          )
        ],
      ) ,
    );

  }

}