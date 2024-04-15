import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:simple_inventory/dashboard/dashbord.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final appDocumentdirectory =
  //     await path_provider.getDApplicationDocumentDirectory();
  // Hive.init(appDocumentdirectory.path);

  // if (kIsWeb) {
  //   await Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //       apiKey: "AIzaSyCR6OZyt70_Nq2o6xCXKApWkmiuVZWA9Kk",
  //       appId: "1:140149397285:web:ec7e73c461f2083984eccc",
  //       messagingSenderId: "140149397285",
  //       projectId: "boardinventory-56b60",
  //     ),
  //   );
  // } else {
  //   await Firebase.initializeApp();
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Dashboard()
    );
  }
}