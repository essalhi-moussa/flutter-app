import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:udemy_flutter/shared/cubit/states.dart';

import '../../modules/archived_tasks/archived_tasks_screen.dart';
import '../../modules/done_tasks/done_tasks_screen.dart';
import '../../modules/new_tasks/new_tasks_screen.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int curentIndex = 0;
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index){
    curentIndex = index;
    emit(AppChangeBottomNaveBarState());
  }


  late Database database;
  List<Map> newTasks = [];
  List<Map> donTasks = [];
  List<Map> archivedTasks = [];

  void createDatabase()  {
    try {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;

      openDatabase(
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
            getDataFromDatabase(database);
            print('database open');
          }
      ).then((value){
        database = value;
        emit(AppCreateDatabaseState());
      });
    } catch (e) {
      print('Error creating database: $e');
    }
  }


  // Future<String?> insertToDatabase({
  //   required String title,
  //   required String time,
  //   required String date,
  // }) async {
  //   try {
  //     await database.transaction((txn) async {
  //       try {
  //         int result = await txn.rawInsert(
  //           'INSERT INTO Tasks(title, date, time, status) VALUES(?, ?, ?, "new")',
  //           [title, date, time],
  //         );
  //
  //         print('$result inserted successfully');
  //         emit(AppInitialState());
  //       } catch (error) {
  //         print('Error when executing rawInsert: $error');
  //       }
  //     });
  //   } catch (error) {
  //     print('Error when opening database transaction: $error');
  //   }
  //
  //   return null; // Ensure a value is always returned.
  // }

  Future<void> insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async
  {
      await database.transaction((txn) async {
          txn.rawInsert(
            'INSERT INTO Tasks(title, date, time, status) VALUES(?, ?, ?, "new")',
            [title, date, time],
          ).then((value){
            print('$value inserted successfully');
            emit(AppInsertDatabaseState());
            getDataFromDatabase(database);
          }).catchError((error){
            print('Error when opening database transaction: $error');
          });
           return null;
      });
  }


  getDataFromDatabase(database)  {
    newTasks = [];
    donTasks = [];
    archivedTasks = [];
    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM Tasks').then((value){
      value.forEach((element)
      {
       if(element['status'] == 'new')
         newTasks.add(element);
       else if(element['status'] == 'done')
         donTasks.add(element);
       else archivedTasks.add(element);
      });
      emit(AppGetDatabaseState());
    });;
  }

  void updateData({
    required String status,
    required int id,
}) async{
    database.rawUpdate(
        'UPDATE Tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value){
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });

  }

  void deleteData({
    required int id,
  }) async{
    database.rawDelete(
        'DELETE FROM Tasks WHERE id = ?', [id]
    ).then((value){
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });

  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }){
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }
}

