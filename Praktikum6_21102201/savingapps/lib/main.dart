import 'package:flutter/material.dart';
import 'package:savingapps/pages/main_page.dart';
import 'package:savingapps/pages/on_boarding_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Saving App',
      routes: {
        OnBoardingPage.nameRoute: (context) => OnBoardingPage(),
        MainPage.nameRoute: (context) => MainPage(),
      },
    );
  }
}
