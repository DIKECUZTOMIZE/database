import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {

  DbHelper._();

  static DbHelper getInstance()=>DbHelper._();

  Database ? mData;

  static const NOTE_TABLE='n_table';
  static const NOTE_COLUMN_ID='n_id';
  static const NOTE_COLUMN_TITLE='n_title';
  static const NOTE_COLUMN_DESC='n_desc';

 Future <Database> initDB()async{

   mData=mData ?? await openDB();
   print('open DB');
   return mData!;

  }

 Future<Database> openDB()async{

   print('open DB');
    var dirPath= await getApplicationDocumentsDirectory();
    var dbPath= join(dirPath.path,'noteDB.db');

    print('creat DB');
    return openDatabase(dbPath,version: 1,onCreate: (db, version) {
      db.execute('create table $NOTE_TABLE ( $NOTE_COLUMN_ID integer primary key autoincrement, $NOTE_COLUMN_TITLE text, $NOTE_COLUMN_DESC text)');
    },);

  }

  /// AddNote
  Future<bool> addNote({required String title, required String desc})async{

   Database db=await initDB();

   int rowsEffected= await db.insert(NOTE_TABLE,  {
     NOTE_COLUMN_TITLE:title,
     NOTE_COLUMN_DESC:desc

   });

   return rowsEffected >0;
  }
    /// Selected:
  Future<List<Map<String, dynamic>>> fectNote()async{

   Database db=await initDB();
   List<Map<String , dynamic>> allNote=await db.query(NOTE_TABLE);
   return allNote;
  }
   /// Update
  Future<bool> updateNote({required String title , required String desc,required int id })async{

   Database db=await initDB();
   int rowsEffected=await db.update(NOTE_TABLE, {
     NOTE_COLUMN_TITLE:title,
     NOTE_COLUMN_DESC:desc,
   },where:'$NOTE_COLUMN_ID = ?',whereArgs: ['$id']
   );
   return rowsEffected >0;

  }
  /// Delet:
  Future<bool> deletNote({required int deletID})async{

   Database db= await initDB();
   int rowsEffected=await db.delete(NOTE_TABLE,
   where: '$NOTE_COLUMN_ID =?',whereArgs: ['$deletID']);
  return rowsEffected >0;
  }


}