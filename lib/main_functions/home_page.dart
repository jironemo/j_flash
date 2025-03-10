import 'package:flutter/material.dart';
import 'package:j_flash/components/navigation_drawer.dart';
import 'package:j_flash/models/card_list.dart';
import 'package:j_flash/main_functions/card_list_page.dart';
import 'package:j_flash/util/db.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  DatabaseHelper db = DatabaseHelper.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomNavigationDrawer(
        selectedIndex: 1,
      ),
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: FutureBuilder(
        future: db.fetchCardLists(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final items = snapshot.data as List<CardList>;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index].name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CardListPage(
                          deckId: items[index].id!,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const Center(
              child: Text("No data available"),
            );
          }
        },
      ),
    );
  }
}
