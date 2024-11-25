import 'package:database/dataBaseOpen/note_Model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();
  static DbHelper getInstance() => DbHelper._();

  static const TABLE_NOTE = 'n_table';
  static const TABLE_ID = 'n_id';
  static const TABLE_TITLE = 'n_title';
  static const TABLE_DESC = 'n_desc';
  static const TABLE_CREATED_AT = 'n_create_at';
  static const TABLE_COMPLETE_AT = 'n_complete_at';

  Database? myDB;

  Future<Database> initDB() async {
    myDB = myDB ?? await openDB();
    print("open DB");
    return myDB!;
  }

  Future<Database> openDB() async {

    var dirPath = await getApplicationDocumentsDirectory();
    var dbPath = await join(dirPath.path, 'noteDB.db');

    print('create DB');

    return openDatabase(dbPath, version: 1, onCreate: (db, version) {

      db.execute('create table $TABLE_NOTE ( $TABLE_ID integer primary key autoincrement, $TABLE_TITLE text, $TABLE_DESC text, $TABLE_CREATED_AT text, $TABLE_COMPLETE_AT text)');
    });
  }

  Future<bool> addNote(NoteModel newNote) async {

    Database db = await initDB();

    int rowsEffecteds = await db.insert(TABLE_NOTE, newNote.toMap());

    return rowsEffecteds > 0;
  }

  /// change Map
  Future<List<NoteModel>> fectNote() async {

    Database db = await initDB();

    List<Map<String, dynamic>> allNote = await db.query(TABLE_NOTE);

    List<NoteModel> mNotes=[];

    for(Map<String,dynamic> eachData in allNote){

      NoteModel eachNote=NoteModel.fromMap(eachData);

      mNotes.add(eachNote);
    }
    return mNotes ;
  }

  Future<bool> update({required String title, required String desc, required int id}) async {
    Database db = await initDB();
    int rowsEfffected = await db.update(
        TABLE_NOTE,
        {
          TABLE_TITLE: title,
          TABLE_DESC: desc,
        }, //where: "$TABLE_ID = $id "

        where: '$TABLE_ID = ?',
        whereArgs: ['$id']);
    return rowsEfffected > 0;
  }

  Future<bool> delet({required int id}) async {
    Database db = await initDB();

    int rowsEffected =
        await db.delete(TABLE_NOTE, where: "$TABLE_ID =?", whereArgs: ['$id']);

    return rowsEffected > 0;
  }
}
