

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:database/class/noteAddCheck//dbHelperSan.dart';

class HomePage1 extends StatelessWidget{

 const  HomePage1({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
     return Scaffold(

       appBar: AppBar(
         centerTitle: true,
         title: Text('Home Page'),
       ),


       body: Container(),

       /// iate link kuribo lagibo : ai button tab kurile note add hoi tare logic loga hoise
       floatingActionButton:FloatingActionButton(onPressed: ()async{

         /// databse dbHelper classt ase khai karone use kora hoise

       Dbhelpersan dbhelpersan = Dbhelpersan.getInstance();

       /// dbHelper bitorh eta function pua jai kahitu hl addNote function:
       /// addNote creat kora function tu ami futurt bolean kora hoise khai karone:
       /// boolean value dubo lagibo,
       //
     bool check=await dbhelpersan.addNote(title: 'My Note',
         desc: 'Today was  a Fantastic day.');



     /// check note add hoise na nai
       if (check){
         print('Note add successfull');
       }else{
         print("Faild to add note ");
       }
       },
         child: Icon(Icons.add),
       ),
         );}
}