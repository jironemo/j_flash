import 'package:flutter/material.dart';
import 'package:j_flash/components/navigation_drawer.dart';
import 'package:j_flash/main_functionaltities/provider/deck_content_provider.dart';

import 'package:j_flash/repository/card_repository.dart';
import 'package:provider/provider.dart';

class DeckContentPage extends StatefulWidget {
  final int deckId;
  const DeckContentPage({super.key, required this.deckId});

  @override
  State<DeckContentPage> createState() => _DeckContentPageState();
}

class _DeckContentPageState extends State<DeckContentPage> {
  CardEntityRepository cardEntityRepository = CardEntityRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomNavigationDrawer(
        selectedIndex: 2,
      ),
      appBar: AppBar(
        title: const Text('Card List Page'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              TextButton(
                child: const Text("Add new card"),
                onPressed: () => Navigator.pushNamed(context, '/add_card'),
              ),
            ],
          ),
          Expanded(
            child: ChangeNotifierProvider(
                create: (_) => DeckContentProvider(widget.deckId),
                child: Consumer<DeckContentProvider>(
                  builder: (context, deckContentProvider, child) {
                    return ListView.builder(
                      itemCount: deckContentProvider.cards.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/card', arguments: [
                                deckContentProvider.cards[index].id
                              ]);
                            },
                            child: Material(
                              elevation: 2,
                              borderRadius: BorderRadius.circular(10),
                              child: ListTile(
                                title: Text(
                                    deckContentProvider.cards[index].front),
                                trailing: IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/edit_card',
                                        arguments: [
                                          deckContentProvider.cards[index].id
                                        ]);
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}
