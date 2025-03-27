import 'package:flutter/material.dart';
import 'package:j_flash/card_management/pages/add_card.dart';
import 'package:j_flash/card_management/pages/edit_card.dart';
import 'package:j_flash/main_functionaltities/card_view_page.dart';
import 'package:j_flash/main_functionaltities/home_page.dart';
import 'package:j_flash/quiz_system/pages/quiz_page.dart';
import 'package:j_flash/quiz_system/pages/score_page.dart';

void main() {
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/card': (context) => const CardViewPage(title: 'Card'),
        '/add_card': (context) => const AddCardPage(),
        '/edit_card': (context) => const EditCardPage(),
        '/quiz': (context) => const QuizPage(),
        '/score': (context) => const ScorePage(),
      },

      //Add a menu drawer for navigation
    );
  }
}
