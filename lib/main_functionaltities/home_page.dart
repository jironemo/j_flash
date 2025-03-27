import 'package:flutter/material.dart';
import 'package:j_flash/components/navigation_drawer.dart';
import 'package:j_flash/models/deck.dart';
import 'package:j_flash/main_functionaltities/deck_content_page.dart';
import 'package:j_flash/repository/deck_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  DeckRepository deckRepository = DeckRepository();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomNavigationDrawer(
        selectedIndex: 1,
      ),
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: FutureBuilder(
        future: deckRepository.fetchDecks(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final items = snapshot.data as List<Deck>;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, '/card',
                          arguments: [items[index].id]);
                    },
                    title: Text(items[index].name),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            icon: const Icon(Icons.play_arrow),
                            onPressed: () {
                              Navigator.pushNamed(context, '/quiz',
                                  arguments: [items[index].id]);
                            }),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DeckContentPage(
                                  deckId: items[index].id!,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ));
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
