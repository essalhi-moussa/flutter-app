import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:udemy_flutter/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:udemy_flutter/modules/done_tasks/done_tasks_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/components/constants.dart';
import 'package:udemy_flutter/shared/cubit/cubit.dart';
import 'package:udemy_flutter/shared/cubit/states.dart';

import '../modules/new_tasks/new_tasks_screen.dart';

class HomeLayout extends StatelessWidget {

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formdKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
       listener: (BuildContext context, AppStates state) {
         if(state is AppInsertDatabaseState){
            Navigator.pop(context);
         }
       },
        builder: (BuildContext context, AppStates state) {
         AppCubit cubit = AppCubit.get(context);
         return Scaffold(
           key: scaffoldKey,
           appBar: AppBar(
             backgroundColor: Color(0xFF00896D),
             title: Center(
               child: Text(
                 cubit.titles[cubit.curentIndex],
               ),
             ),
           ),
           // body: tasks.length == 0 ? Center(child: CircularProgressIndicator()) : cubit.screens[cubit.curentIndex],
           body: ConditionalBuilder(
             condition: state is! AppGetDatabaseLoadingState,
             builder: (context) => cubit.screens[cubit.curentIndex],
             fallback: (context) => Center(child: CircularProgressIndicator())
           ),
           floatingActionButton: FloatingActionButton(
             backgroundColor: Color(0xFF00896D),
             onPressed: () {
               if (cubit.isBottomSheetShown){
                 if(formdKey.currentState!.validate()){
                   // cubit.insertToDatabase(title: titleController.text, time: timeController.text, date: dateController.text);
                   cubit.insertToDatabase(title: titleController.text, time: timeController.text, date: DateFormat.yMMMd().format(DateTime.now()));
                 };
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
                               // defaultFormField(
                               //   controller: timeController,
                               //   type: TextInputType.datetime,
                               //   onTap: (){
                               //     showTimePicker(
                               //         context: context,
                               //         initialTime: TimeOfDay.now()).then((value){
                               //       timeController.text = value!.format(context).toString();
                               //       print(value?.format(context));
                               //     });
                               //   },
                               //   validate: (String? value) {
                               //     if (value!.isEmpty) {
                               //       return 'time must not be empty';
                               //     }
                               //     return null;
                               //   },
                               //   label: 'Task time',
                               //   prefix: Icons.watch_later_outlined,
                               // ),
                               // SizedBox(
                               //   height: 16.0,
                               // ),
                               // defaultFormField(
                               //   controller: dateController,
                               //   type: TextInputType.datetime,
                               //   onTap: (){
                               //     showDatePicker(
                               //       context: context,
                               //       initialDate: DateTime.now(),
                               //       firstDate:  DateTime.now(),
                               //       lastDate:  DateTime.parse('2026-12-31'),
                               //     ).then((value){
                               //       print(DateFormat.yMMMd().format(value!));
                               //       dateController.text = DateFormat.yMMMd().format(value!);
                               //     });
                               //   },
                               //   validate: (String? value) {
                               //     if (value!.isEmpty) {
                               //       return 'date must not be empty';
                               //     }
                               //     return null;
                               //   },
                               //   label: 'Task Date',
                               //   prefix: Icons.calendar_today,
                               // ),
                             ],
                           ),
                         ),
                       ),
                   elevation: 20.0,
                 ).closed.then((value){
                   cubit.changeBottomSheetState(isShow: false, icon: Icons.edit);
                 });
                 cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
               }
             },
             child: Icon(
               cubit.fabIcon,
             ),
           ),
           bottomNavigationBar: BottomNavigationBar(
             type: BottomNavigationBarType.fixed,
             currentIndex: cubit.curentIndex,
             onTap: (index){
               cubit.changeIndex(index);
             },
             selectedItemColor: Color(0xFF00896D),
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
        },
      ),
    );
  }


  Future<String> getName() async {
    return 'Ahmed Ali';
  }



}

