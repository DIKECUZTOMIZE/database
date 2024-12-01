// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
//
// class DbHelper2 {
//
//   DbHelper2._();
//
//  ///  step:1
//  // static final DbHelper dbHelper=DbHelper._();
//
//  /// step2:
//   static  DbHelper2 getInstance()=>DbHelper2._();
//
//   Database? myDB;
//
//  Future<Database>  initDB()async{
//
//    ///  if null code short:
//     myDB = myDB  ?? await openDB();
//     return myDB!;
//
//  ///  mediim : code
//    // if(myDB != null){
//    //   return myDB!;
//    // }else  {
//    //   myDB=await openDB();
//    //   return myDB!;
//    // }
//
//    ///  long code
//      // if(myDB != null){
//      //   return myDB!;
//      // }else{
//      //  return await openDB();
//      // }
//
//   }
//
//  Future<Database> openDB()async{
//
//    var   dirPath=await  getApplicationDocumentsDirectory();
//
//    var  dbPath=await  join(dirPath.path,'noteDB.db');
//
//   return openDatabase(dbPath,version: 1,onCreate: (db,version){
//
//        db.execute('creat note table ( id_note interger primary key autoicrement ,n_title text , n_desc text  )');
//
//    });
//   }
//
//   /// initdb aru opendb call kora main function hl addNOte:
//   /// *use a noteAdd click kuri title aru desc dekha pabo tar pisot khi type kuribo paribo:
//   void addNote({ required String title ,required  String desc})async{
//
//    ///  aitu function  user a show kora table tu add kuribo lagibo  database add kuribo lagibo
//
//     /// data type database karone await kora hoise , aitu db hl name
//     Database db =await initDB();
//
//     /// initdb a db othai loi anibo tarpiost db r bhitorot insertion kam kora start hobo
//     db.insert('note', {
//
//
//     });
//
//   }
//
//
// }
//
