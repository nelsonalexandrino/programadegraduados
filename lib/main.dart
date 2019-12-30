import 'package:flutter/material.dart';
import './pages/intro_page.dart';
import './pages/survey_1_page.dart';
import './pages/survey_2_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Programa de graduados',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Brave'),
      home: IntroPage(),
      routes: {
        SurveyOnePage.routeName: (context) => SurveyOnePage(),
        DISCSurveyPage.routeName: (context) => DISCSurveyPage(),
      },
    );
  }
}
