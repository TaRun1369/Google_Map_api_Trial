import 'package:flutter/material.dart';
import 'package:screens_for_touristapp/Screens/home_page_first.dart';
import 'package:screens_for_touristapp/Screens/loading_page.dart';
import 'package:screens_for_touristapp/Screens/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:screens_for_touristapp/auth/firebase_options.dart';
import 'package:screens_for_touristapp/auth/widget_tree.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WidgetTree(),
    );
  }
}

