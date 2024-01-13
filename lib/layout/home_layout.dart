import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:udemy_flutter/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:udemy_flutter/modules/done_tasks/done_tasks_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';

import '../modules/new_tasks/new_tasks_screen.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int curentIndex = 0;
  List<Widget> screen = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  late Database database;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formdKey = GlobalKey<FormState>();
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  List<Map> tasks = [];

  @override
  void initState(){
    super.initState();
    createDatabase();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          titles[curentIndex],
        ),
      ),
      body: screen[curentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isBottomSheetShown){
            if(formdKey.currentState!.validate()){
              insertToDatabase(
                title: titleController.text,
                date: dateController.text,
                time: timeController.text,
              ).then((value){
                Navigator.pop(context);
                isBottomSheetShown = false;
                setState(() {
                  fabIcon =  Icons.edit;
                });
              });

            }
            print(isBottomSheetShown = true);
          }else {
            scaffoldKey.currentState?.showBottomSheet(
                  (context) =>
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(20.0),
                    child: Form(
                      key: formdKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min ,
                        children: [
                          defaultFormField(
                              controller: titleController,
                              type: TextInputType.text,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Title must not be empty';
                                }
                                return null;
                              },
                              label: 'Task Title',
                              prefix: Icons.title,
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          defaultFormField(
                            controller: timeController,
                            type: TextInputType.datetime,
                            onTap: (){
                              showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now()).then((value){
                                timeController.text = value!.format(context).toString();
                                    print(value?.format(context));
                              });
                            },
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'time must not be empty';
                              }
                              return null;
                            },
                            label: 'Task time',
                            prefix: Icons.watch_later_outlined,
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                            defaultFormField(
                            controller: dateController,
                            type: TextInputType.datetime,
                            onTap: (){
                                showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate:  DateTime.now(),
                                    lastDate:  DateTime.parse('2026-12-31'),
                                ).then((value){
                                    print(DateFormat.yMMMd().format(value!));
                                    dateController.text = DateFormat.yMMMd().format(value!);
                                });
                            },
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'date must not be empty';
                              }
                              return null;
                            },
                            label: 'Task Date',
                            prefix: Icons.calendar_today,
                          ),
                        ],
                      ),
                    ),
                  ),
              elevation: 20.0,
            ).closed.then((value){
              isBottomSheetShown = false;
              setState(() {
                fabIcon =  Icons.edit;
              });
            });
            isBottomSheetShown = true;
            setState(() {
              fabIcon =  Icons.add;
            });
          }
        },
        child: Icon(
          fabIcon,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: curentIndex,
        onTap: (index){
          setState(() {
            curentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
            Icons.menu,
            ),
            label: 'Tasks'
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.check_circle_outline,
              ),
              label: 'Done'
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.archive_outlined,
              ),
              label: 'Archived'
          ),
        ],

      ),
    );
  }


  Future<String> getName() async {
    return 'Ahmed Ali';
  }

  void createDatabase() async {
    try {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;

       database = await openDatabase(
          'todo.db',
          version: 1,
          onCreate: (database, version)  {
            print('database created');
            database.execute('CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)').then((value){
              print('table created');
            }).catchError((Error){
              print('error when creating table ${Error.toString()} ');
            });
          },
          onOpen: (database){
            getDataFromDatabase(database).then((value){
              tasks = value;
            });
            print('database open');
          }
      );
    } catch (e) {
      print('Error creating database: $e');
    }
  }

  // void insertToDatabase({
  //     required String title,
  //     required String time,
  //     required String date,
  //     })
  //     {
  //   try {
  //     // return database.transaction((txn) async {
  //     //   int result = await txn.rawInsert(
  //     //     'INSERT INTO Tasks(title, date, time, status) VALUES("first task" , "0222", "111", "active")'
  //     // );
  //     database.transaction((txn){
  //       txn.rawInsert('INSERT INTO Tasks(title, date, time, status) VALUES("first task" , "0222", "111", "active")').then((value) {
  //       print('$value inserted successfuly');
  //     }).catchError((er){
  //       print('error when Inserting New Record  ${er.toString()} ');
  //     });
  //
  //       // print('$result inserted successfully');
  //       // return null;
  //   });
  //   } catch (error) {
  //     print('Error when inserting new record: $error');
  //   }
  // }

  Future  insertToDatabase(
  {
    required String title,
    required String time,
    required String date,
  }
  ) async {
    try {
      return  await database.transaction((txn) async {
        try {
          int result = await txn.rawInsert(
            'INSERT INTO Tasks(title, date, time, status) VALUES(?, ?, ?, "new")',
            [title, date, time],
          );

          print('$result inserted successfully');
        } catch (error) {
          print('Error when executing rawInsert: $error');
        }
      });
    } catch (error) {
      print('Error when opening database transaction: $error');
    }
  }

  Future<List<Map>> getDataFromDatabase(database) async {
    return await database.rawQuery('SELECT * FROM Tasks');
  }

}
