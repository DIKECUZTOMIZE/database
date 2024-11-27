import 'package:database/dbHelper.dart';

class NoteModel {
  /// 1. Blueprint:
  int? id;
  String tilte;
  String desc;
   String created_at;

  /// 2.Constructor:
  NoteModel({
    this.id,
    required this.tilte,
    required this.desc,
     required this.created_at,

  });

  /// 3. map to model:FromMap user pora pua jabo
  //static NoteModel fromMap(){} :sam kam kore toldre alternate
  // NoteModel okl retrun kore i special function
  factory NoteModel.fromMap(Map<String, dynamic> map) {

    return NoteModel(

      /// object retrun:
        id:    map[DbHelper.NOTE_COLUMN_ID],
        tilte: map[DbHelper.NOTE_COLUMN_TITLE],
        desc:  map[DbHelper.NOTE_COLUMN_DESC],
        created_at:map[DbHelper.NOTE_COLUMN_CREATED_AT],

    );
  }

  /// 2. Model to Map(toMap) user dia hobo:
  Map<String, dynamic> toMap() => {
        DbHelper.NOTE_COLUMN_TITLE: tilte,
        DbHelper.NOTE_COLUMN_DESC: desc,
        DbHelper.NOTE_COLUMN_CREATED_AT:created_at,
      };
}
