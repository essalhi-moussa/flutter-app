import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter/modules/home/home_screen.dart';
import 'package:udemy_flutter/modules/users/users_screen.dart';
import 'package:udemy_flutter/shared/bloc_observer.dart';

import 'layout/home_layout.dart';
import 'modules/bmi/bmi_screen.dart';
import 'modules/counter/counter_screen.dart';
import 'modules/login/login_screen.dart';
import 'modules/messenger/messenger_screen.dart';

// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  Future main() async {

// Initialize FFI
//     sqfliteFfiInit();
//
//
//     databaseFactory = databaseFactoryFfi;
    runApp(MyApp());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),
    );
  }
}

