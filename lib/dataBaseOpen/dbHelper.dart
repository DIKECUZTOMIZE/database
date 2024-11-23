import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {

  DbHelper._();

  ///  step:1
  // static final DbHelper dbHelper=DbHelper._();

  /// step2:
  static DbHelper getInstance() => DbHelper._();

  static const TABLE_NOTE  = 'n_table';
  static const TABLE_ID    = 'n_id';
  static const TABLE_TITLE = 'n_title';
  static const TABLE_DESC  = 'n_desc';

  ///time and date variable:
  static const TABLE_CREATED_AT  ='n_create_at';
  static const TABLE_COMPLETE_AT ='n_complete_at';

  Database? myDB;

  Future<Database> initDB() async {

    ///  if null code short:
    myDB = myDB ?? await openDB();
    print("open DB");
    return myDB!;

    ///  mediim : code
    // if(myDB != null){
    //   return myDB!;
    // }else  {
    //   myDB=await openDB();
    //   return myDB!;
    // }

    ///  long code
    // if(myDB != null){
    //   return myDB!;
    // }else{
    //  return await openDB();
    // }

  }

  Future<Database> openDB() async {


    ///* data/data/com.skvks.dkvmd/databases/noteDB.db
    var dirPath = await getApplicationDocumentsDirectory();

    var dbPath = await join(dirPath.path, 'noteDB.db');

    ///* database ek bare creat hoi jud path exixtent thakile nuhuli age
    ///*path creat kuri database open kuribo lagibo
    ///data base open hua pisot on creat call huar loge loge  table creat hoi jai mane ami querish bonabo
    ///lagibo.

    print('create DB');
    return openDatabase(dbPath, version: 1, onCreate: (db, version) {


      ///  db.excute kuri multiple table creat kuribo pari kitnu table name match hobo nlage
      ///  aru eta tabler column r name beleg column r lgt mathc hobo nlage kintu
      ///  beleg table luar pisot agor tabler column name same hulio iku nai,
      ///  context clear rakhibo lage jate problme creat hoobo pare judi problme creat hoi tatia
      ///  confuse hole error aru crashese huar posible hobo pare,(table joint)(front key concpet :data conect kuri
      ///  data olabo pare)
      ///
      db.execute('create table $TABLE_NOTE ( $TABLE_ID integer primary key autoincrement, $TABLE_TITLE text, $TABLE_DESC text, $TABLE_CREATED_AT text, $TABLE_COMPLETE_AT text)');
    });
  }

  /// initdb aru opendb call kora main function hl addNOte:
  /// *use a noteAdd click kuri title aru desc dekha pabo tar pisot khi type kuribo paribo:
  ///
  // addNote june cll kurise tai gm pabo lagibo khai korne boolean kora hobo but async ase na
  //so ami bool kuriba nuru tatia ami kuribo future kuribo lagibo,

//bool addNote({required title, required desc })async{

  Future<bool> addNote({required String title, required String desc , required String dueDateAt}) async {
    Database db = await initDB();

    /// usere jaibar addNote call kuribo khai bare initdb call hobo,
    /// table name aru key value t add kuribo lagibo ,key value mane hl kiman column ase kahitu add
    /// kuribo lagibo

    //* db.insert('note', {
    //
    //  //1. requiredment put hoi gl
    //  'n_title': title,
    //  'n_desc':desc,

    //2.table insert hoise na nai kenkoi gm pua jabo khitu logic use kora hobo:
    //nhli error  ba excepton ahi gole gm naoabo kahikarone gm puar logic logabo lagibo successfuly
    // excuted hoisi na nai.

    //database creat korute    koi je how many row effected,
    // kiman row effected hoise future t loi ahi kua hoise

    int rowsEffecteds = await db.insert(TABLE_NOTE, {

      // Tolot duta column hoi: ai duta table t  add kuri,  db r bhitorot  row tu insert kuri dibo lage,
      // judi row insert hoi jai tatia  database undert  ntun row add hoi jabo aru  ntun raw add hole eta row effect
      // hoi jabo  tarpisot   iman ro effect hoisi buli gm pua jabo,eta row add mane eta row effect hoi,

      TABLE_TITLE: title,
      TABLE_DESC: desc,
      TABLE_CREATED_AT:DateTime.now().millisecondsSinceEpoch.toString(),
      TABLE_COMPLETE_AT:dueDateAt,
    });

    // roweffected 1 hulio true hobo,
    // rowEffected judi true hoi tatia  note add hoise mane successfull judi tru nhoi note ad hua nai
    // mane not successfull

    //*short code

    // boolean value retrun(>)
    return rowsEffecteds > 0;

    //*long code
    //   if(rowsEffecteds > 0) {
    //     return true;
    //   }else{
    //     return false;
    //   }

  }


  /// Select:
  Future<List<Map<String,dynamic>>> fectNote() async {
    Database db = await initDB();

    List<Map<String,dynamic>> allNote=await db.query(TABLE_NOTE);
    return allNote;

  }


  Future<bool> update ({required String title , required String desc,required int id })async{

    Database db =await initDB();
   int rowsEfffected=await db.update(TABLE_NOTE,{

    TABLE_TITLE : title,
    TABLE_DESC :desc,
    } ,//where: "$TABLE_ID = $id "

     where: '$TABLE_ID = ?',  whereArgs: ['$id']
 );
   return  rowsEfffected >0;
  }


  //new id lua hoise:
     Future<bool> delet({required int id})async{

    Database db=await initDB();

   int rowsEffected= await db.delete(TABLE_NOTE,
    where:"$TABLE_ID =?" ,whereArgs:['$id']  );

   return rowsEffected >0;
  }


}


///* addNote important point:  main kam hoise addNote function t jetia addNote call korahoise  callr logte
///title aru desc  pass kora hoise , aru title aru desc value judi table add kuribo loga hoi tatia
///database needed hoi khai karone database initialize kora hoise initdb r thourg di  tarpisot database r
///value2 assign huar pisot   db bhitort database operation kora hoise jene insert
///




