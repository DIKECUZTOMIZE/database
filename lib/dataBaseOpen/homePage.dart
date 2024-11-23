
import 'package:database/dataBaseOpen/dbHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class HomePage extends StatefulWidget{



  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  DbHelper dbHelper =DbHelper.getInstance();

  List<Map<String,dynamic>> mData=[];

  var titleController=TextEditingController();
  var descController=TextEditingController();
  //variable duedate
  String dueDate='';

  // aitu date show kuribor babe logic aru aitu pakage instal kora pisot he ulai:
  DateFormat dtFormate= DateFormat.MMMEd();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotes();
  }

   getNotes()async{
    mData=await dbHelper.fectNote();
    setState(() {});

   }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Text('Home Page'),
      ),

      body:mData.isNotEmpty ? ListView.builder(
        itemCount: mData.length,
        itemBuilder:(context, index) {
        return ListTile(

          leading: Text('${index+1}'),
          title:Text(mData[index][DbHelper.TABLE_TITLE]) ,
          subtitle: Column(
            children: [
              Text(mData[index][DbHelper.TABLE_DESC]),

              SizedBox(
                height: 11,
              ),


              /// date : shpw kora hoise aru package o install kuribo lagi bo:
              /// intl: ^0.20.0
              /// date time milisecond r pora bonabo lagibo karon dtfromate tok lage date and time aru
              /// mili second database r pora ahise aru mData tuk integer value convert kuribor babe
              /// int .pars kuri convert kora hoise string r pora (mdata srting valu hoi)
              /// statr hoisil prothome integer tarpisot mdata t goi string hoi gl aru atia mdata r pora
              /// integer value kuribo lago hoise
              Text(dtFormate.format(DateTime.fromMillisecondsSinceEpoch(int.parse(mData[index][DbHelper.TABLE_CREATED_AT]))))
              // Text(dtFormate.format(DateTime.fromMillisecondsSinceEpoch(int.parse(mData[index][DbHelper.TABLE_CREATED_AT])))),
            ],
          ),
          trailing:SizedBox(
            width:100,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

              IconButton(onPressed: (){

                /// olde type kora show kuri bor babr get kora hoise
                 titleController.text=mData[index][DbHelper.TABLE_TITLE];
                descController.text=mData[index][DbHelper.TABLE_DESC];

          showModalBottomSheet(
          enableDrag: false,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
          context: context, builder: (_){

            //
          return getBottumSheet(isupdate: true,nId: mData[index][DbHelper.TABLE_ID]);});},

             icon: Icon(Icons.edit),
              ),


                IconButton(onPressed: ()async{

                  // id match kora hoise
                 bool check=await dbHelper.delet(id: mData[index][DbHelper.TABLE_ID]);

                 // fect note thoka data store hoi ase take loi delet kora hoise
                  if(check){
                    getNotes();
                  }
                }, icon: Icon(Icons.delete,color: Colors.red,)),
              ],
            ),
          ) ,
        );
      },) :
          Center(child: Text('not add note')),



      // iate link kuribo lagibo : ai button tab kurile note add hoi tare logic loga hoise
      floatingActionButton:FloatingActionButton(onPressed: ()async{

        titleController.clear();
        descController.clear();
        // /// databse dbHelper classt ase khai karone use kora hoise
        //
        // DbHelper dbhelper = DbHelper.getInstance();
        //
        // /// dbHelper bitorh eta function pua jai kahitu hl addNote function:
        // /// addNote creat kora function tu ami futurt bolean kora hoise khai karone:
        // /// boolean value dubo lagibo,
        // //
        // bool check=await dbhelper.addNote(title: 'My Note',
        //     desc: 'Today was  a Fantastic day.');

        showModalBottomSheet(
            enableDrag: false,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
            context: context, builder: (_){  return getBottumSheet();
        });
      },
        child: Icon(Icons.add),
      ),
    );}


  // by default false: true kam kuribo lagibo
  //same contain and repeatated code bur deferent between kuribor babe:
  Widget getBottumSheet({bool isupdate = false, int nId=0}){

    return Container(
      padding: EdgeInsets.all(21),
      height: 400,
      width: double.infinity,

      decoration:BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21)
      ) ,
      child: Column(
        children: [


          // true :update nuhli by default false: add note
          Text(isupdate ? 'update note': 'add note'),

          SizedBox(
            height: 11,
          ),


          TextField(
            controller: titleController,
            decoration: InputDecoration(

              label: Text('title'),
              hintText: 'Enter your title',

              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(21),),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(21) ),

            ),
          ),

          SizedBox(height: 11,),

          // overlayt context ahibo a karone tree ka hisa ,
          OutlinedButton(onPressed: ()async{

            // user date loi ahibo ate null value put kuribo
            DateTime ? selectedDate= await showDatePicker(context: context,

                // ajir pora date time dibo pare
                firstDate: DateTime.now(),

                //last date time dibo pora=e
                lastDate: DateTime(9999));

            // mili second olabor abe logic:date piker current date time  user date pick r pora loi
            // database add kuri dia hoise


              print(selectedDate!.millisecondsSinceEpoch.toString());
                dueDate=selectedDate.millisecondsSinceEpoch.toString();

          }, child: Text('choose date')),

          SizedBox(height: 11,),

          TextField (
            controller: descController,
            maxLines: 4,
            minLines: 4,
            decoration: InputDecoration(


              label: Text('desc'),
              hintText: 'Enter your desc',

              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(21),),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(21) ),



            ),
          ),

          SizedBox(height: 11,),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              OutlinedButton(onPressed: ( )async{

          if(titleController.text.isNotEmpty && descController.text.isNotEmpty){

            // ai variable2 hoise je by default kora hoise karon
            // atia okl tru kam kuribo lagibo , judi true nhoi false hobo mane
            //iku nhoi,khai krone duta jagat  tru hoise na nai gm pabor babe use kora hoise
            bool check=false;


            // isUpdate tr judi kam kuribo loga take tatia true nuhili
            // by default  false hobo parametr condition tu a hoise use kuribo pare
            // khulute jagat
            // isupdate true  kam kora hoise
            //judi isupdate tot true ba false hoise
           if(isupdate){

             // check true hole call hobo upadte
             check=await dbHelper.update(
                 title: titleController.text.toString(),
                 desc: descController.text.toString()
                 , id: nId);

          }else{
             // by defalut false:isUpadate
             // check true hole add call hobo:
            check=await dbHelper.addNote(
                title: titleController.text.toString(),
                desc: descController.text.toString(),

                dueDateAt: dueDate,

            );
          }
           if(check){
             //judi actual update hoise tothapito pop kuribo lagibo
             //judi hua nai  update tatia add note actual hoise tatia o pop kuribo lagibio

             Navigator.pop(context);
             getNotes();
           }
          }
              },
                  //true tap kurile hobo update aru by default false
                  child: Text(isupdate ?'update':'Add')),

              SizedBox(width: 11,),

              OutlinedButton(onPressed: ( ){

                Navigator.pop(context);
              }, child: Text('Cancel')),
            ],
          )
        ],
      ),
    );
  }


}