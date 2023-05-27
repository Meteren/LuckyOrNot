import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_pages/front_page.dart';
import 'provider/navigation_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    /*options: FirebaseOptions(
        apiKey: "AIzaSyASTYePIwLBpF97AcTTK4lWxw8u16sJURM",
        projectId: "myapp-30771",
        messagingSenderId: "519321099158",
        appId: "1:519321099158:web:629147fdf88d1227ae1bb7",)*/
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NavigationProvider() ,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lucky Or Not',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const frontPage(),
      ),
    );
  }
}

