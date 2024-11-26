import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{

  DbHelper._();

  static DbHelper getInstance()=>DbHelper._();
  Database ? mData;

  static const NOTE_TABLE='n_table';
  static const NOTE_COLUMN_ID='n_id';
  static const NOTE_COLUMN_TITLE='n_title';
  static const NOTE_COLUMN_DESC='n_desc';
   // static const NOTE_COLUMN_CREATED_AT='n_created_at';
   // static const NOTE_COLUMN_COMPLETED_AT='n_completed_at';

  Future<Database>  initDB()async{

    mData=mData ?? await openDB();
    return mData!;

    // if(mData !=null){;
    //   return mData;
    // }else{
    //   return await openDB();
    // }


    // if(mData= await openDB()){
    //   return mData!;
    // }else{
    //   return await openDB();
    // }
  }

  Future<Database> openDB()async{

    var dirPath=await getApplicationDocumentsDirectory();
    var dbPath=join(dirPath.path,'noteDB.db');

    return openDatabase(dbPath,version: 1,onCreate: (db, version) {
      db.execute('create table $NOTE_TABLE ( $NOTE_COLUMN_ID integer primary key autoicrement, $NOTE_COLUMN_TITLE text, $NOTE_COLUMN_DESC text,)');
    },);

  }

  /// Insert:
  Future<bool> addNote ({ required String title , required String desc})async{
    Database db=await initDB();
    int rowsEffected=await db.insert(NOTE_TABLE, {
       NOTE_COLUMN_TITLE:title,
      NOTE_COLUMN_DESC:desc,
      // NOTE_COLUMN_CREATED_AT:DateTime.now().millisecondsSinceEpoch.toString(),
      // NOTE_COLUMN_COMPLETED_AT:date,
    });
    return rowsEffected > 0;
  }
  /// select:
  Future<List<Map<String , dynamic>>> fectNote ()async{
    Database db=await initDB();
    List<Map<String,dynamic>> allNote= await db.query(NOTE_TABLE);
    return allNote;

  }
  /// update:
  Future<bool> updateNote ({required String title, required String desc, required int updateId})async{
    Database db= await initDB();
    int rowsEffected=await db.update(NOTE_TABLE,{
      NOTE_COLUMN_TITLE:title,
      NOTE_COLUMN_DESC:desc,
    },where: '$NOTE_COLUMN_ID=?',whereArgs: ['$updateId']
        //where:'$NOTE_COLUMN_ID = $id'
         );
    return rowsEffected > 0;
  }
  /// delet:
  Future<bool> deletNote ({required int deletID})async{
    Database db =await initDB();
    int rowsEffected=await db.delete(NOTE_TABLE,
    where: '$NOTE_COLUMN_ID=?',whereArgs: ['$deletID']);
    return rowsEffected > 0;
  }
}