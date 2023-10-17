import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'login.dart';
import 'package:flutter/material.dart';


Future<void> main()  async{
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.grey),
          labelStyle: TextStyle(color: Colors.grey),
        ),
        snackBarTheme: const SnackBarThemeData(
          actionTextColor: Colors.white,
        ),
      ),
      //darkTheme: ThemeData.dark(), // standard dark theme
      //themeMode: ThemeMode.system,
      // theme: ThemeData.dark(),
      home: const LoginPage(),
    );
  }
}
