import 'package:flutter/material.dart';
import 'package:j_flash/components/navigation_drawer.dart';
import 'package:j_flash/models/card.dart';
import 'package:j_flash/util/db.dart';

class CardListPage extends StatefulWidget {
  final int deckId;
  const CardListPage({super.key, required this.deckId});

  @override
  State<CardListPage> createState() => _CardListPageState();
}

class _CardListPageState extends State<CardListPage> {
  DatabaseHelper db = DatabaseHelper.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomNavigationDrawer(
        selectedIndex: 2,
      ),
      appBar: AppBar(
        title: const Text('Card List Page'),
      ),
      body: FutureBuilder(
        future: db.fetchCards(widget.deckId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final items = snapshot.data as List<CardEntity>;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/card',
                        arguments: [items[index].id]);
                  },
                  child: Card(
                    elevation: 2,
                    color: Colors.blueGrey,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(items[index].front),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Text("No data available");
          }
        },
      ),
    );
  }
}
