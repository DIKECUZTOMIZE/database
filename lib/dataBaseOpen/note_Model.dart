
import 'package:database/dataBaseOpen/dbHelper.dart';

/// Modale classs
class NoteModel {
  int? id;
  String title;
  String desc;
  String createdAt;

  NoteModel(
      {this.id,
      required this.title,
      required this.desc,
      required this.createdAt});


  factory NoteModel.fromMap(map){
    return NoteModel(
        id: map[DbHelper.TABLE_ID],
        title:map[DbHelper.TABLE_TITLE] ,
        desc: map[DbHelper.TABLE_DESC],
        createdAt:map[DbHelper.TABLE_CREATED_AT]);
  }


  ///convert model to map
  Map<String,dynamic>toMap()=> {
        DbHelper.TABLE_TITLE: title,
        DbHelper.TABLE_DESC: desc,
        DbHelper.TABLE_CREATED_AT: createdAt,

      };




}

