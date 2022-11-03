import 'package:flutter/material.dart';
import 'package:screens_for_touristapp/Screens/home_page_first.dart';
import 'package:screens_for_touristapp/Screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePageFirst();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
