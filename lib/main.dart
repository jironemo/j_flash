import 'package:flutter/material.dart';
import 'package:j_flash/main_functions/card_view_page.dart';
import 'package:j_flash/main_functions/home_page.dart';

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
      },

      //Add a menu drawer for navigation
    );
  }
}
