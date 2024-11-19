import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 import 'package:database/noteAddCheck/homePage1.dart';
void main (){
  runApp(App());
}

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

     return MaterialApp(
       home: HomePage1(),
     );
  }
}