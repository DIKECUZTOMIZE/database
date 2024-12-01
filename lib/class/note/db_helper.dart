//  import 'package:flutter/material.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
//
// /// Eta class:
// class DbHelper1 {
//
// /// step 1 .Eta Object Copy with Privat Constructor:
//   DbHelper1._();
//
//
//   /// Dbhelper single term object class hoi  gl eake koi single trem class.
//
//   /// privat Dheleper r valu access instance nk pass kora hoise: atia judi data base helper r object
//   ///  use kuribo loga thake tatia instance tu he call kuribio lagibo  tar pisot dbhelper
//   ///  object pai jabo.
//
//   ///  instance :instance a single term object refer kuribo etia jiman inatsance use kurile ,
//   ///  aru multiple defernt instance creat huar bond hoi gl judi multiple dferent
//   ///  object judi creat nhoi tatia asyncronize r kam khotom ,atia okl syncronize he excution
//   ///  hobo aru multiple data base r copy bnua o minimuz hoi gl mane nhoi a ,
//
//   ///   variable type DbHelper:
//  // static final DbHelper instance=DbHelper._();
//
//
//  ///  step 2:Function type Dbhelper:
//   static DbHelper1 getInstance()=>DbHelper1._();
//
// ///   step 3.
//     Database? myDB;
//
//     /// step 4:check kora hoise myDB ase na nai  ,call kora hoise first initDB .
//    /// judi databaseopen hoise tatitia bar bar  open nhibir babe ai condition kora hoise
//     Future<Database> initDB()async{
//
//       /// judi initialize hoise mane bar bar open kuribo nlage
//       /// judi init hua nai open kuribi lagiobo
//
//       //if condition
//       // if(myDB != null){
//       //   return myDB!;
//       // }else{
//
//         /// openDB function t loi jabo judi init hua nai : await use kora hose karon
//         /// openDb future data base retrun kurise
//      //  return await openDB()
//      //      myDB= await openDB();
//      //  }
//
//
//   /// simple: if null
//       myDB=myDB ?? await openDB();
//       print('db opened');
//       return myDB!;
//
//     }
//
//     Future<Database> openDB()async{
//
//       /// ate data base creat hobo getappplication t : retrun futurt anibo pathtu,
//       /// path ahi gl ai directory document to loi ke  mane directory get hoi gl but
//       /// directory bhitort data base filse creat hua nai ,ai filse tu creat kuiribor babe
//       /// collective db path bonabo lagibo.
//       var dirPath =await getApplicationDocumentsDirectory();
//
//       /// join operation path mane duta ptah join hoi jai.
//       /// i.directory path mane hl data base creat krute iate store kora files,
//       /// ii.noteDB.db: niteDB mane filer name aru db mane extaintion() ,
//       /// ai duta join kora pasot collective path hoi jabo ,ai colective path tu
//       /// openDatabse t set kuridibo lage
//       var dbPath = join(dirPath.path, 'noteDB.db');
//
//       /// function sqlite packegt pua jai: ai function tu aru path loi ahe lgt,
//       /// colective path set kora hl  tarpisot data base open hoio jabo aru retrun
//       /// hobo futur of data base, async use
//
//
//
//      ///  opendatabase open kuri dibo kintu agee check kuribo je ai pathot  opendatabase
//       /// exist korise na nai judi  kurise opendatabase open kuri di retrun kuri dobo
//       /// jate ami  data base quries excuted kuribo pari.
//       /// judi data base a creat nai aitu pathot  tatia age creat kuribo tarpisot open kiri
//       ///  path loi ani eate retrun kuri dobo jate ami operation perfrom kuribo paro.
//
//       ///creat huar pasot table creat kuribo lagibo:
//       ///table creat  kuribor babe  duta bstu pua jai  eta hl version ,2no.on creat,
//       ///vresion 1 pora start kuribo pari mane khur pora start kuribo lage,
//       ///oncreat :call back funton hoi
//       return openDatabase(dbPath,version: 1,onCreate:(db, version){
//
//         print('db creat');
//
//         //create table:
//         // db mane database create
//         db.execute(
//
//           /// Table name:
//             'creat table note '
//
//           /// colunm name:  note id primary key set
//             '(n_id '
//
//           /// data type:
//                 'integer '
//
//            ///  primary key: atleas primary key hoba lage  jot primary kry set kore
//
//                 'primary key autoincrement, n_title, n_desc text'')'
//         );
//
//       }  );
//     }
//
//
//     /// DbHelper r tu call kurim addNote r dhara : ait qurise likha hobo
//     void addNote({required String tittle, required String desc})async{
//
//       /// initDB call kora hobo karon opent Dbt he condition ase true falsh:
//       Database db =await initDB();
//
//       db.insert('note', {});
//     }
//
//
//
// } /// privat bonale first erroer show kuribo karon ami object
// /// creat kuribi nuaru,tatr babe ami static
// /// kuribo lagibo karon dbHelper pora ami kiba use kurile object
// /// creat kuribo lagibo tatia static kuri object use kiri valu pass kurbo pari
//
//
//
//
// /// first time app open krute  first initDb call kora hobo aru false  a hobo tatia
// /// else t openDB call hoi jabo, tarpisot path creat hobo tarpisot data base crteat hobo
// /// tarpisot  table creat kuriobo lagibo creat huar pisot aru retrun hobo opendatabase r
// /// reference retrun hobo tarpisot myDb assign hoi jabo first kam hoi gl ,
// /// 2nd time app open kora pasot initdb t call hobo jate conditon true ne falsh aku eabr
// /// aneo true hobo , myDb null nhoi tatia   tolor process tu nhoi aru direct refrenc(myDB initialize hoi ase tolore process
// /// khini  mane refarence  hoi gl )
// /// retrun hoi jabo database ? myDb t variable t jate store hoi thake ,
//
//
// /// judi app close hua pisot open kora hoi jai tatia mydb null pua jabo tatia
// /// init db a check kuribo judi null pai open db cll hobo aru tarpisot aru
// /// databaseopen hobo direct karon databaseopen ase agore path r khoite open kora aru duba duba
// /// dierctory path  table cerat kuribo nalge atia  so databaseopen thoka karone
// /// direct retrun kuri dibo refarance tarpisot mydb t agin initialize hoi jabo.
// /// jetia loike app open hoi thakibo tatia loike data base call kora time initdb r pora retrun hoi jabo
// /// tlot loike najai  judi app close kuri open kurile aru 2number dore same process hobo,
