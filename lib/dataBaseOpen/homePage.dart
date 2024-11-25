import 'package:database/dataBaseOpen/dbHelper.dart';
import 'package:database/dataBaseOpen/note_Model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  DbHelper dbHelper = DbHelper.getInstance();

  List<NoteModel> mData = [];

  var titleController = TextEditingController();
  var descController = TextEditingController();

  String dueDate = '';

  DateFormat dtFormate = DateFormat.MMMEd();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotes();
  }

  void getNotes() async {
    mData = await dbHelper.fectNote();
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
      body: mData.isNotEmpty ? ListView.builder(
              itemCount: mData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text('${index + 1}'),
                  title: Text(mData[index].title),
                  subtitle: Column(
                    children: [
                      Text(mData[index].desc),

                      SizedBox(
                        height: 11,
                      ),

                      Text(dtFormate.format(DateTime.fromMillisecondsSinceEpoch(
                          int.parse(mData[index].createdAt))))
                      // Text(dtFormate.format(DateTime.fromMillisecondsSinceEpoch(int.parse(mData[index][DbHelper.TABLE_CREATED_AT])))),
                    ],
                  ),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                        /// update
                        IconButton(
                          onPressed: () {
                            titleController.text = mData[index].title;
                            descController.text = mData[index].desc;

                            showModalBottomSheet(
                                enableDrag: false,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(21)),
                                context: context,
                                builder: (_) {
                                  //

                                  return getBottumSheet(
                                      isupdate: true,
                                      nId: mData[index].id!);
                                });
                          },
                          icon: Icon(Icons.edit),
                        ),

                       /// delet
                        IconButton(
                            onPressed: () async {
                              bool check = await dbHelper.delet(
                                  id: mData[index].id!);

                              if (check) {
                                getNotes();
                              }
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(child: Text('not add note')),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          titleController.clear();
          descController.clear();

          showModalBottomSheet(
              enableDrag: false,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(21)),
              context: context,
              builder: (_) {
                return getBottumSheet();
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget getBottumSheet({bool isupdate = false, int nId = 0}) {
    return Container(
      padding: EdgeInsets.all(21),
      height: 400,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(21)),
      child: Column(
        children: [
          Text(isupdate ? 'update note' : 'add note'),

          SizedBox(
            height: 11,
          ),

          TextField(
            controller: titleController,
            decoration: InputDecoration(
              label: Text('title'),
              hintText: 'Enter your title',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(21),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21)),
            ),
          ),

          SizedBox(
            height: 11,
          ),

          OutlinedButton(
              onPressed: () async {
                DateTime? selectedDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(9999));

                print(selectedDate!.millisecondsSinceEpoch.toString());
                dueDate = selectedDate.millisecondsSinceEpoch.toString();
              },
              child: Text('choose date')),

          SizedBox(
            height: 11,
          ),

          TextField(
            controller: descController,
            maxLines: 4,
            minLines: 4,
            decoration: InputDecoration(

              label: Text('desc'),
              hintText: 'Enter your desc',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(21),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(21)),
            ),
          ),

          SizedBox(
            height: 11,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                  onPressed: () async {
                    if (titleController.text.isNotEmpty &&
                        descController.text.isNotEmpty) {
                      bool check = false;

                      if (isupdate) {
                        // check true hole call hobo upadte
                        check = await dbHelper.update(
                            title: titleController.text.toString(),
                            desc: descController.text.toString(),
                            id: nId);
                      } else {
                        check = await dbHelper.addNote((NoteModel(
                            title: titleController.text.toString(),
                            desc: descController.text.toString(),
                            //cahnge:
                            createdAt: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString())));
                      }
                      if (check) {
                        //judi actual update hoise tothapito pop kuribo lagibo
                        //judi hua nai  update tatia add note actual hoise tatia o pop kuribo lagibio

                        Navigator.pop(context);
                        getNotes();
                      }
                    }
                  },
                  //
                  child: Text(isupdate ? 'update' : 'Add')),

              SizedBox(
                width: 11,
              ),

              OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
            ],
          )
        ],
      ),
    );
  }
}
